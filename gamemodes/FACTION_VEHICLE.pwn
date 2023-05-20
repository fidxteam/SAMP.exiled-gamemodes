#include <YSI\y_hooks>

new GovVehicle[MAX_VEHICLES char],
    NewsVehicle[MAX_VEHICLES char],
    MedicVehicle[MAX_VEHICLES char],
    PoliceVehicle[MAX_VEHICLES char];

stock FactionVehicle()
{
    CreateDynamicPickup(1239, 23, 1583.6830,-1711.7793,5.8906, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("[KENDARAAN POLISI]\n{7fffd4}/sppv\n/dspv", COLOR_YELLOW, 1583.6830,-1711.7793,5.8906, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Butcher
    
    CreateDynamicPickup(1239, 23, 1521.2555,-1846.1063,13.5469, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("[KENDARAAN PEMERINTAH]\n{7fffd4}/sppv\n/dspv", COLOR_YELLOW, 1521.2555,-1846.1063,13.5469, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Butcher

    CreateDynamicPickup(1239, 23, 1131.1956,-1331.7938,13.5815, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("[KENDARAAN EMS]\n{7fffd4}/sppv\n/dspv", COLOR_YELLOW, 1131.1956,-1331.7938,13.5815, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Butcher

    CreateDynamicPickup(1239, 23, 744.7720,-1334.6416,13.8414, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("[KENDARAAN NEWS]\n{7fffd4}/sppv\n/dspv", COLOR_YELLOW, 744.7720,-1334.6416,13.8414, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Butcher
}

hook OnGameModeInit()
{
    FactionVehicle();
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_PDPV)
    {
        if(response)
        {
			static vehid;

            switch(listitem)
            {
                case 0:
                {
                    vehid = CreateVehicle(597,1578.5859,-1711.7571,5.6608,359.4702,125,1,-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}CopCar!");
                }
                case 1:
                {
                    vehid = CreateVehicle(528,1578.6368,-1711.6633,5.9341,0.1507,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}FBI Truck!");
                }
                case 2:
                {
                    vehid = CreateVehicle(601,1578.8387,-1711.2455,5.6494,358.9759,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}SWAT Tank!");
                }
                case 3:
                {
                    vehid = CreateVehicle(427,1578.5808,-1710.2982,6.0225,358.8365,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Enforcer!");
                }
                case 4:
                {
                    vehid = CreateVehicle(599,1578.5568,-1711.6350,6.0797,358.7740,0,1-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Police Ranger!");
                }
                case 5:
                {
                    vehid = CreateVehicle(560,1578.5782,-1712.0898,5.5950,0.1479,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Sultan!");
                }
                case 6:
                {
                    vehid = CreateVehicle(468,1579.2260,-1712.2238,5.5598,357.3901,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Sanchez!");
                }
                case 7:
                {
                    vehid = CreateVehicle(523,1578.6840,-1710.7562,5.4604,0.5958,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}HPV-1000!");
                }
                case 8:
                {
                    vehid = CreateVehicle(522,1578.7307,-1711.7657,5.4556,357.8504,0,0-1,1);
                    PoliceVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "POLISI");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}NRG-500!");
                }
            }
        }
    }
	if(dialogid == DIALOG_GOVPV)
    {
        if(response)
        {
			static vehid;

            switch(listitem)
            {
                case 0:
                {
                    vehid = CreateVehicle(521,1519.4961,-1846.0326,13.1154,0.0000,0,0,-1,1);
                    GovVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "PEMERINTAH");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}FCR!");
                }
                case 1:
                {
                    vehid = CreateVehicle(411,1524.1926,-1846.0502,13.2783,359.9834,0,0,-1,1);
                    GovVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "PEMERINTAH");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Infernus!");
                }
                case 2:
                {
                    vehid = CreateVehicle(597,1578.5859,-1711.7571,5.6608,359.4702,125,1,-1,1);
                    GovVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "PEMERINTAH");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Helicopter!");
                }
            }
        }
    }
	if(dialogid == DIALOG_MDPV)
    {
        if(response)
        {
			static vehid;
			
            switch(listitem)
            {
                case 0:
                {
                    vehid = CreateVehicle(407,1123.9598,-1328.0906,13.5611,2.1494,3,3,-1,1);
                    MedicVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "EMS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Firetruck!");
                }
                case 1:
                {
                    vehid = CreateVehicle(442,1124.0769,-1325.5616,13.3714,358.9128,0,1,-1,1);
                    MedicVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "EMS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Romero!");
                }
                case 2:
                {
                    vehid = CreateVehicle(426,1124.4673,-1325.1415,13.3160,359.6121,0,1,-1,1);
                    MedicVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "EMS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Premier!");
                }
                case 3:
                {
                    vehid = CreateVehicle(586,1124.5917,-1324.9471,13.1034,359.7567,0,1,-1,1);
                    MedicVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "EMS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Wayfarer!");
                }
                case 4:
                {
                    vehid = CreateVehicle(487,1160.4917,-1307.1208,31.9720,270.3253,0,1,-1,1);
                    MedicVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "EMS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Maverick!");
                }
            }
        }
    }
	if(dialogid == DIALOG_NEWSPV)
    {
        if(response)
        {
			static vehid;
			
            switch(listitem)
            {
                case 0:
                {
                    vehid = CreateVehicle(413,736.4727,-1338.6395,13.9107,246.8581,119,1,-1,1);
                    NewsVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "NEWS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Pony!");
                }
                case 1:
                {
                    vehid = CreateVehicle(405,737.4014,-1343.0978,13.7532,246.4516,11,1,-1,1);
                    NewsVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "NEWS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Sentinel!");
                }
                case 2:
                {
                    vehid = CreateVehicle(582,737.1486,-1338.7200,13.8981,245.9921,114,118,-1,1);
                    NewsVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "NEWS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Newsvan!");
                }
                case 3:
                {
                    vehid = CreateVehicle(461,737.2278,-1338.8624,13.4260,242.9003,53,1,-1,1);
                    NewsVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "NEWS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}PCJ!");
                }
                case 4:
                {
                    vehid = CreateVehicle(488,741.9838,-1371.2443,25.8793,359.9999,2,29,-1,1);
                    NewsVehicle{vehid} = true;
                    SetVehicleVirtualWorld(vehid, 0);
                    LinkVehicleToInterior(vehid, 0);
                    SetValidVehicleHealth(vehid, 1000);
                    SetVehicleFuel(vehid, 1000);
                    SetVehicleNumberPlate(vehid, "NEWS");
                    PutPlayerInVehicle(playerid, vehid, 0);
                    PlayerPlaySound(playerid, 5201, 0.0, 0.0, 0.0);
                    Info(playerid, "Berhasil Spawn Faction Vehicle {00ff00}Maverick!");
                }
            }
        }
    }
    return 1;
}

CMD:sppv(playerid, params[])
{

    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1583.6830,-1711.7793,5.8906))
	{
        if(pData[playerid][pFaction] != 1)
            return Error(playerid, "Kamu bukan Polisi!");

        ShowPlayerDialog(playerid, DIALOG_PDPV, DIALOG_STYLE_LIST, "Kendaraan Polisi", "CopCar\nFBI Truck\nSWAT Tank\nEnforcer\nPolice Ranger\nSultan\nSanchez\nHPV-1000\nNRG-500", "Pilih", "Batal");
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1521.2555,-1846.1063,13.5469))
	{
        if(pData[playerid][pFaction] != 2)
            return Error(playerid, "Kamu bukan Pemerintah!");

        ShowPlayerDialog(playerid, DIALOG_GOVPV, DIALOG_STYLE_LIST, "Kendaraan Pemerintah", "FCR\nInfernus", "Pilih", "Batal");
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1131.1956,-1331.7938,13.5815))
	{
        if(pData[playerid][pFaction] != 3)
            return Error(playerid, "Kamu bukan EMS!");

        ShowPlayerDialog(playerid, DIALOG_MDPV, DIALOG_STYLE_LIST, "Kendaraan Ems", "Firetruck\nRomero\nPremier\nWayfarer\nMaverick", "Pilih", "Batal");
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 744.7720,-1334.6416,13.8414))
	{
        if(pData[playerid][pFaction] != 4)
            return Error(playerid, "Kamu bukan NEWS!");

        ShowPlayerDialog(playerid, DIALOG_NEWSPV, DIALOG_STYLE_LIST, "Kendaraan News", "Pony\nSentinel\nNewsvan\nPCJ\nMaverick", "Pilih", "Batal");
    }
    return 1;
}

CMD:dspv(playerid, params[])
{
    new vehid = GetPlayerVehicleID(playerid);

    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1583.6830,-1711.7793,5.8906))
	{
        if(pData[playerid][pFaction] != 1)
            return Error(playerid, "Kamu bukan Polisi!");

        if(PoliceVehicle{vehid})
        {
            DestroyVehicle(vehid);
            PoliceVehicle{vehid} = false;
            Info(playerid, "Berhasil despawned!");
        }
    
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1521.2555,-1846.1063,13.5469))
	{
        if(pData[playerid][pFaction] != 2)
            return Error(playerid, "Kamu bukan Pemerintah!");

        if(GovVehicle{vehid})
        {
            DestroyVehicle(vehid);
            GovVehicle{vehid} = false;
            Info(playerid, "Berhasil despawned!");
        }
    
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 1131.1956,-1331.7938,13.5815))
	{
        if(pData[playerid][pFaction] != 3)
            return Error(playerid, "Kamu bukan EMS!");

        if(MedicVehicle{vehid})
        {
            DestroyVehicle(vehid);
            MedicVehicle{vehid} = false;
            Info(playerid, "Berhasil despawned!");
        }
    
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 744.7720,-1334.6416,13.8414))
	{
        if(pData[playerid][pFaction] != 4)
            return Error(playerid, "Kamu bukan NEWS!");

        if(NewsVehicle{vehid})
        {
            DestroyVehicle(vehid);
            NewsVehicle{vehid} = false;
            Info(playerid, "Berhasil despawned!");
        }
    
    }
    return 1;
}

