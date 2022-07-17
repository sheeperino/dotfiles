

/*
 * Kinetic movement  acceleration algorithm
 *
 *  current speed = I + A * T/50 + A * 0.5 * T^2 | maximum B
 *
 * T: time since the mouse movement started
 * E: mouse events per second (set through MOUSEKEY_INTERVAL, UHK sends 250, the
 *    pro micro on my Signum 3.0 sends only 125!)
 * I: initial speed at time 0
 * A: acceleration
 * B: base mouse travel speed
 */
 
global I := 1
global A := 13
global T := 10
msgbox, % I + A * T/50 + A * 0.5 * T**2 
; current speed =  + A * T/50 + A * 0.5 * T^2 | maximum B