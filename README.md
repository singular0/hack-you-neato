# Hack You, Neato!

ESPHome Neato D8, D9 and D10 start button operaton.

## Background

Neato Robotics’ smart vacuum platform cloud backend has been [shut down ahead of schedule in late
2025](https://uk.news.yahoo.com/shuttered-robot-vacuum-maker-neato-171604498.html), effectively
crippling the automated features that once defined the products. The company itself ceased
operations under Vorwerk ownership in 2023, and while there was an initial promise to maintain
cloud support for five years after the closure, that commitment has been reversed hypocritically
citing evolving cybersecurity and regulatory burdens. As a result, app-based functions such as
scheduled runs, remote start, room mapping, virtual no-go zones and turbo mode no longer work once
the servers went offline, leaving users with only the basic manual start button and severely limited
convenience.

This situation highlights lack of open APIs and strict dependency of each and every imaginable
function on proprietary vendor cloud infrastructure. Add digitally signed closed source firmware
to the mix and you and up with no feasible paths for local control or community-driven software
alternatives allowing to preserve key functions after vendor market exit. Though we end up with
effectively “bricked” smart features on hardware that otherwise still works, demonstrating the
risks of closed ecosystems.

## The Hack

Unlike earlier models D8, D9 and D10 do not have open serial debug interface that would allow
external control. So realistically the only app-based function that could be restored with
relatively low effort is remote and scheduled start via start button press emulation.

I have put together [Super Mini ESP32-C3 controller board](https://www.amazon.co.uk/dp/B0DMNBWTFD)
and [74HC4051 based multiplexer breakout board](https://www.amazon.co.uk/dp/B07MPB4VZL) that would
connect to Neato D8 physical controls breakout board and emulate short and long button press.
ESPHome is used to enable seamless [Home Assistant](https://www.home-assistant.io) connectivity
and remote control and scheduled runs as a consequence.

![Hack You, Neato! mounted on a top half of the robot case near physical controls breakout board](docs/hack-you-neato.jpeg)

### Pinout

> [!WARNING]
> I am not an electric engineer and this may potentially contain some critical commutation error
> that could lead to the damage of controller and/or the vacuum electronics. Do it on your own risk.

You must short 74HC4051 `VEE` and `GND`.

| ESP32C3 | 74HC4051 | Neato Controls Breakout |
| ------- | -------- | ----------------------- |
| `GPIO1` | `E`      |                         |
| `GPIO2` | `S2`     |                         |
| `GPIO3` | `S1`     |                         |
| `GPIO4` | `S0`     |                         |
| `5V`    | `VCC`    | `+5V` debug point       |
| `GND`   | `GND`    | `GND` debug point       |
|         | `Z`      | Play button             |
|         | `Y0`     | Play button             |

### Mount

I have 3D printed mount plate for ESP32 and multiplexer boards, but this was only justified by
prototyping convenience and my OCD tendencies :) You can find [OpenSCAD](https://openscad.org)
model for it in this repo as well.

[Jersey 25 font](https://fonts.google.com/specimen/Jersey+25) is used for model back engraving.

### Install and Run

Install ESPHome, connect the controller and complie and flash the firmware:

```sh
esphome run hack-you-neato.yaml
```
