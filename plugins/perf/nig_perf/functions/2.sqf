0 spawn
{
    onEachFrame
    {
        _start = ASLToAGL eyePos player;
        _end = (_start vectorAdd (eyeDirection player vectorMultiply 50));
        drawLine3D [ _start, _end, [0,1,0,1]];

        _pos_player = getPos player;
        _screen = screenToWorld [0.5,0.5];
        _get_direction = ((((_screen select 0) - (_pos_player select 0)) atan2 ((_screen select 1) - (_pos_player select 1))) + 360) % 360;
        hintSilent format ["Direction %1", (round _get_direction)];
    };
};