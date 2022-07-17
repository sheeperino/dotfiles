; global ACCN ; controls accel while movements keys are held down, its scaled by sqrt(1/2)x for diagonal movements
;             ; Setting this to 0 corresponds to an accelerating force that exactly balances out the friction component.

; global FRIC := 1 ; controls decel(eration) due to coulombian kinetic force*
;             ; Setting this to 255 should bring the cursor to a standstill within FIXME 1ms even in the absence of drag.
; global DRAG ; controls an additional contribution** to deceleration when moving at high speeds, but becomes negligible at slow speeds. FIXME ∝v²**
; global MAXS ; sets the number of pixels moved in 15 ms

; ; *https://en.wikipedia.org/wiki/Coulomb_damping
; ; **https://en.wikipedia.org/wiki/Drag_equation

; ; a(t) = fric + (key_down(t) ? diagonal(t) ? accn/√2 : accn : 0)


; key_down()
; {
;     return (mouse_up || mouse_down || mouse_left || mouse_right)
; }

; diagonal()
; {
;     return ((mouse_down || mouse_up) && (mouse_left || mouse_right))
; }

; dir()

; global mouse_left := True
; global mouse_up := True
; if diagonal()
;     msgbox, lool

; accn :=  
; a := fric + (key_down() ? diagonal() ? accn/sqrt(2) : accn : 0)
a := 24
msgbox, % +agt
; MK_KINETIC_MOUSE_ACCN 	24 	Acceleration for mouse cursor
; MK_KINETIC_MOUSE_DRAG 	16 	Drag coefficient for mouse cursor
; MK_KINETIC_MOUSE_FRIC 	32 	Friction coefficient for mouse cursor
; MK_KINETIC_MOUSE_MAXS 	128 	Maximum speed for mouse cursor