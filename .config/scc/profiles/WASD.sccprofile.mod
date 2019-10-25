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
            "action": "button(Keys.KEY_Q)"
        }, 
        "LPAD": {
            "action": "button(Keys.BTN_MIDDLE)"
        }, 
        "RB": {
            "action": "button(Keys.KEY_E)"
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
        "action": "ring(ball(XY(mouse(Rels.REL_HWHEEL), mouse(Rels.REL_WHEEL))), click(dpad(button(Keys.KEY_F), button(Keys.KEY_N), None, button(Keys.KEY_M))))"
    }, 
    "pad_right": {
        "action": "rotate(24.2, smooth(8, 0.78, 2.0, ball(mouse())))"
    }, 
    "stick": {
        "action": "dpad(button(Keys.KEY_W), button(Keys.KEY_S), button(Keys.KEY_A), button(Keys.KEY_D))"
    }, 
    "trigger_left": {
        "action": "trigger(50, button(Keys.BTN_RIGHT))"
    }, 
    "trigger_right": {
        "action": "trigger(50, button(Keys.BTN_LEFT))"
    }, 
    "version": 1.3
}