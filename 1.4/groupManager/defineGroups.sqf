// This script should be called whenever there is a chance a group has been left empty,
// so that any empty groups are re-initialised by the server, and can therefore be called upon in other methods:


private ["_sideNum"];
if (isServer) then {
    _sideNum = _this select 0;
    switch (_sideNum) do {	
        case 1: {
            if (isNull alphaGroup1) then {alphaGroup1 = createGroup west; publicVariable "alphaGroup1";};
            if (isNull alphaGroup2) then {alphaGroup2 = createGroup west; publicVariable "alphaGroup2";};
            if (isNull alphaGroup3) then {alphaGroup3 = createGroup west; publicVariable "alphaGroup3";};
            if (isNull bravoGroup1) then {bravoGroup1 = createGroup west; publicVariable "bravoGroup1";};
            if (isNull bravoGroup2) then {bravoGroup2 = createGroup west; publicVariable "bravoGroup2";};
            if (isNull bravoGroup3) then {bravoGroup3 = createGroup west; publicVariable "bravoGroup3";};
            if (isNull charlieGroup1) then {charlieGroup1 = createGroup west; publicVariable "charlieGroup1";};
            if (isNull charlieGroup2) then {charlieGroup2 = createGroup west; publicVariable "charlieGroup2";};
            if (isNull charlieGroup3) then {charlieGroup3 = createGroup west; publicVariable "charlieGroup3";};
        };
        case 2: {
            if (isNull alphaOGroup1) then {alphaOGroup1 = createGroup east; publicVariable "alphaOGroup1";};
            if (isNull alphaOGroup2) then {alphaOGroup2 = createGroup east; publicVariable "alphaOGroup2";};
            if (isNull alphaOGroup3) then {alphaOGroup3 = createGroup east; publicVariable "alphaOGroup3";};
            if (isNull bravoOGroup1) then {bravoOGroup1 = createGroup east; publicVariable "bravoOGroup1";};
            if (isNull bravoOGroup2) then {bravoOGroup2 = createGroup east; publicVariable "bravoOGroup2";};
            if (isNull bravoOGroup3) then {bravoOGroup3 = createGroup east; publicVariable "bravoOGroup3";};
            if (isNull charlieOGroup1) then {charlieOGroup1 = createGroup east; publicVariable "charlieOGroup1";};
            if (isNull charlieOGroup2) then {charlieOGroup2 = createGroup east; publicVariable "charlieOGroup2";};
            if (isNull charlieOGroup3) then {charlieOGroup3 = createGroup east; publicVariable "charlieOGroup3";};
        };
        case 3: {
            if (isNull alphaIGroup1) then {alphaIGroup1 = createGroup resistance; publicVariable "alphaIGroup1";};
            if (isNull alphaIGroup2) then {alphaIGroup2 = createGroup resistance; publicVariable "alphaIGroup2";};
            if (isNull alphaIGroup3) then {alphaIGroup3 = createGroup resistance; publicVariable "alphaIGroup3";};
            if (isNull bravoIGroup1) then {bravoIGroup1 = createGroup resistance; publicVariable "bravoIGroup1";};
            if (isNull bravoIGroup2) then {bravoIGroup2 = createGroup resistance; publicVariable "bravoIGroup2";};
            if (isNull bravoIGroup3) then {bravoIGroup3 = createGroup resistance; publicVariable "bravoIGroup3";};
            if (isNull charlieIGroup1) then {charlieIGroup1 = createGroup resistance; publicVariable "charlieIGroup1";};
            if (isNull charlieIGroup2) then {charlieIGroup2 = createGroup resistance; publicVariable "charlieIGroup2";};
            if (isNull charlieIGroup3) then {charlieIGroup3 = createGroup resistance; publicVariable "charlieIGroup3";};
        };
    };
};

