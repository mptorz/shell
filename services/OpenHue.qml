pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<var> lights: []
    property list<var> rooms: []

    function setLightOnState(id: string, state: bool): void {
        const command = ["openhue", "set", "light", id, state ? "--on" : "--off"];
        setter.command = command;
        setter.running = true;
    }

    function setLightBrightness(id: string, value: real): void {
        const command = ["openhue", "set", "light", id, "--brightness", String(Math.round(value))];
        setter.command = command;
        setter.running = true;
    }

    function setRoomOnState(id: string, state: bool): void {
        const command = ["openhue", "set", "room", id, state ? "--on" : "--off"];
        setter.command = command;
        setter.running = true;
    }

    function setRoomBrightness(id: string, value: real): void {
        const command = ["openhue", "set", "room", id, "--on", "--brightness", String(Math.round(value))];
        setter.command = command;
        setter.running = true;
    }

    function refresh(): void {
        if (!getLightsProc.running)
            getLightsProc.running = true;
        if (!getRoomsProc.running)
            getRoomsProc.running = true;
    }

    Process {
        id: getLightsProc

        command: ["openhue", "get", "lights", "--json"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const parsed = JSON.parse(text);
                    const result = [];
                    for (const light of parsed) {
                        result.push({
                            id: light.HueData.id,
                            name: light.HueData.metadata.name,
                            brightness: light.HueData.dimming ? light.HueData.dimming.brightness : 0,
                            dimmable: !!light.HueData.dimming,
                            on: light.HueData.on.on
                        });
                    }
                    root.lights = result;
                } catch (e) {}
            }
        }
    }

    Process {
        id: getRoomsProc

        command: ["openhue", "get", "rooms", "--json"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const parsed = JSON.parse(text);
                    const result = [];
                    for (const room of parsed) {
                        const devices = room.Devices || [];
                        const lightsInRoom = devices.filter(d => d.Light !== null);
                        const anyOn = lightsInRoom.some(d => d.Light.HueData.on.on);
                        let avgBrightness = 0;
                        const dimmableLights = lightsInRoom.filter(d => d.Light.HueData.dimming);
                        if (dimmableLights.length > 0) {
                            const total = dimmableLights.reduce((sum, d) => sum + d.Light.HueData.dimming.brightness, 0);
                            avgBrightness = total / dimmableLights.length;
                        }
                        result.push({
                            id: room.Id,
                            name: room.Name,
                            brightness: avgBrightness,
                            on: anyOn
                        });
                    }
                    root.rooms = result;
                } catch (e) {}
            }
        }
    }

    Process {
        id: setter

        running: false
        onExited: root.refresh()
    }

    Component.onCompleted: refresh()
}
