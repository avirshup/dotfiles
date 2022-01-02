Some notes for my own reproduciblity when it all goes wrong:

### Differentiated left_command and right_command keys

**kinesis**: Kinesis is in mac mode, but with `=x` to map the top-cluster modifier keys to the default non-pc keys (right ctrl, right alt, left alt, left ctrl).
 
**karabiner simple mappings**: map these back to map to (left_cmd, right_option, right_option, right_cmd). The left/right command keys are different so that hitting both can activate the hyper layer special.

### Kinesis Remappings

`scroll lock` toggles between scroll lock as itself vs. scroll lock as apple power key. Should be left in scroll lock key mode.

In hardware, cyclically permuted these key groups (also changed the keycaps accordingly):
up/down -> \[/\] -> page up/down

Caps lock is remapped to escape (then use complex action to intepret strike as escape). Unfortunately don't have simultaneous access to all left/right modifier pairs in any of the kinesis presets, so can't just directly remap it to control.

Keypad mode is mapped almost entirely to regular keycaps EXCEPT the number bar which is mapped to reverse-shift macros


### dumbass pedals

Currently locked in:
left pedal: alt-ctrl-release-alt-ctrl-right-arrow-release
middle pdeal: F6
right pedal: alt-ctrl-release-alt-ctrl-left-arrow-release


### Things that don't work
 - hold-down actions for most keys - using "to_if_alone" makes these fire when the key is _released_, which makes them feel weird and laggy, and disrupts shift and shortcut. Using plain "to" will make them fire normally before firing the hold-down action, meaning you end up with inadvertant keystrokes.

 - Kinesis macros and Karabiner, often: firing a macro can interrupt keys being held down

 - reprogramming pedals with Windows 8.1 32-bit, at least in a VM even with USB passthrough

TODO: fix the current clashes between keypad mode and number row macros (shifting that row back to numbers gives us a lot of inadvertant parentheses - shifts are being activated by keyboard macros, then interpreted by karabiner as quick strikes)
TODO: fix clashes between hardware keypad mode and the karabiner keypad mode (currently toggled by `pause`) - number keys don't current work right

Future
 - double-press actions?
 - visual feedback for toggled modes (in menu bar or physical leds - don't need to use hardware macros if can hook this up to karabiner somehow) (PR to karabiner to take advantage of menu bar icon somehow?)

