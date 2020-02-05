{
    "_": "", 
    "buttons": {
        "A": {
            "action": "button(Keys.KEY_ENTER)"
        }, 
        "B": {
            "action": "button(Keys.KEY_ESC)"
        }, 
        "BACK": {
            "action": "button(Keys.KEY_BACKSPACE)"
        }, 
        "C": {
            "action": "hold(menu('Default.menu'), menu('Default.menu'))"
        }, 
        "CPADPRESS": {
            "action": "button(Keys.BTN_LEFT)"
        }, 
        "LB": {
            "action": "button(Keys.KEY_LEFTCTRL)"
        }, 
        "LPAD": {
            "action": "button(Keys.BTN_MIDDLE)"
        }, 
        "RB": {
            "action": "button(Keys.KEY_LEFTALT)"
        }, 
        "RPAD": {
            "action": "button(Keys.BTN_LEFT)"
        }, 
        "START": {
            "action": "button(Keys.KEY_LEFTSHIFT)"
        }, 
        "STICKPRESS": {
            "action": "keyboard()"
        }, 
        "X": {
            "action": "button(Keys.KEY_SPACE)"
        }, 
        "Y": {
            "action": "button(Keys.KEY_TAB)"
        }
    }, 
    "cpad": {
        "action": "mouse()"
    }, 
    "gyro": {}, 
    "is_template": false, 
    "menus": {}, 
    "pad_left": {
        "action": "circular(mouse(Rels.REL_WHEEL))"
    }, 
    "pad_right": {
        "action": "rotate(24.2, smooth(8, 0.78, 2.0, ball(mouse())))"
    }, 
    "stick": {
        "action": "dpad(button(Keys.KEY_UP), button(Keys.KEY_DOWN), button(Keys.KEY_LEFT), button(Keys.KEY_RIGHT))"
    }, 
    "trigger_left": {
        "action": "trigger(50, button(Keys.BTN_RIGHT))"
    }, 
    "trigger_right": {
        "action": "trigger(50, button(Keys.BTN_LEFT))"
    }, 
    "version": 1.4
}