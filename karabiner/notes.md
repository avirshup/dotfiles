Some notes for my own reproduciblity when it all goes wrong:

### Differentiated left_command and right_command keys

Kinesis is in mac mode, but with `=x` to map the top-cluster modifier keys to the default non-pc keys (right ctrl, right alt, left alt, left ctrl). 

Then use karabiner simple mappings to map these back to map back to the mac layout (left_cmd, right_option, right_control, right_cmd) except with different left and right command keys, allowing special 2-command shortcuts that combine the two otherwise identical command keys. (Actually unclear if the kinesis mac mode maps both cmds to the same key or just my fault with interference from another karabinedr mod. )

### Current hardware state

`=scroll lock` toggles between scroll lock as itself vs. scroll lock as apple power key. Should be left in scroll lock key mode.

In hardware, cyclically permuted these key groups (also changed the keycaps accordingly):
up/down -> \[/\] -> page up/down

Caps lock is remapped to escape (then use complex action to intepret hold down as right_alt)
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