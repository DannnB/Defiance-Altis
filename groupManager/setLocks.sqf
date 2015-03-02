// This script is responsible for unlocking squads if they have less than the defined minimum size:
private ["_localUnit"];
disableSerialization;
_localUnit = _this select 0;

// Check if any group has < Krok_minimum_lock_size players in it, if it does, unlock the group:
switch (side _localUnit) do {
    case west: {
        if(count units alphaGroup1 < Krok_minimum_lock_size)then{locked1 = false; publicVariable "locked1";};
        if(count units alphaGroup2 < Krok_minimum_lock_size)then{locked2 = false; publicVariable "locked2";};
        if(count units alphaGroup3 < Krok_minimum_lock_size)then{locked3 = false; publicVariable "locked3";};
        if(count units bravoGroup1 < Krok_minimum_lock_size)then{locked4 = false; publicVariable "locked4";};
        if(count units bravoGroup2 < Krok_minimum_lock_size)then{locked5 = false; publicVariable "locked5";};
        if(count units bravoGroup3 < Krok_minimum_lock_size)then{locked6 = false; publicVariable "locked6";};
        if(count units charlieGroup1 < Krok_minimum_lock_size)then{locked7 = false; publicVariable "locked7";};
        if(count units charlieGroup2 < Krok_minimum_lock_size)then{locked8 = false; publicVariable "locked8";};
        if(count units charlieGroup3 < Krok_minimum_lock_size)then{locked9 = false; publicVariable "locked9";};
    };
    case east: {
        if(count units alphaOGroup1 < Krok_minimum_lock_size)then{lockedO1 = false; publicVariable "lockedO1";};
        if(count units alphaOGroup2 < Krok_minimum_lock_size)then{lockedO2 = false; publicVariable "lockedO2";};
        if(count units alphaOGroup3 < Krok_minimum_lock_size)then{lockedO3 = false; publicVariable "lockedO3";};
        if(count units bravoOGroup1 < Krok_minimum_lock_size)then{lockedO4 = false; publicVariable "lockedO4";};
        if(count units bravoOGroup2 < Krok_minimum_lock_size)then{lockedO5 = false; publicVariable "lockedO5";};
        if(count units bravoOGroup3 < Krok_minimum_lock_size)then{lockedO6 = false; publicVariable "lockedO6";};
        if(count units charlieOGroup1 < Krok_minimum_lock_size)then{lockedO7 = false; publicVariable "lockedO7";};
        if(count units charlieOGroup2 < Krok_minimum_lock_size)then{lockedO8 = false; publicVariable "lockedO8";};
        if(count units charlieOGroup3 < Krok_minimum_lock_size)then{lockedO9 = false; publicVariable "lockedO9";};
    };
    case resistance: {
        if(count units alphaIGroup1 < Krok_minimum_lock_size)then{lockedI1 = false; publicVariable "lockedI1";};
        if(count units alphaIGroup2 < Krok_minimum_lock_size)then{lockedI2 = false; publicVariable "lockedI2";};
        if(count units alphaIGroup3 < Krok_minimum_lock_size)then{lockedI3 = false; publicVariable "lockedI3";};
        if(count units bravoIGroup1 < Krok_minimum_lock_size)then{lockedI4 = false; publicVariable "lockedI4";};
        if(count units bravoIGroup2 < Krok_minimum_lock_size)then{lockedI5 = false; publicVariable "lockedI5";};
        if(count units bravoIGroup3 < Krok_minimum_lock_size)then{lockedI6 = false; publicVariable "lockedI6";};
        if(count units charlieIGroup1 < Krok_minimum_lock_size)then{lockedI7 = false; publicVariable "lockedI7";};
        if(count units charlieIGroup2 < Krok_minimum_lock_size)then{lockedI8 = false; publicVariable "lockedI8";};
        if(count units charlieIGroup3 < Krok_minimum_lock_size)then{lockedI9 = false; publicVariable "lockedI9";};
    };
};
