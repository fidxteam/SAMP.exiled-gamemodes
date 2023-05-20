#include <YSI_Coding\y_hooks>

#define MAX_GARAGE 500

enum    garageData
{
    garageOwner[MAX_PLAYER_NAME],
    garageOwnerID,
    garagePrice,
	Float: garagePosX,
	Float: garagePosY,
	Float: garagePosZ,
	garageInt,
	garageWorld,
	garagePickup,
	Text3D: garageLabel
}

new GarageData[MAX_GARAGE][garageData],
	Iterator:Garages<MAX_GARAGE>;

function LoadGarage()
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
  	{
 		new id, i = 0, owner[128];
		while(i < rows)
		{
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name(i, "owner", owner);
			format(GarageData[id][garageOwner], 128, owner);
            cache_get_value_name_int(i, "ownerid", GarageData[id][garageOwnerID]);
            cache_get_value_name_int(i, "price", GarageData[id][garagePrice]);
			cache_get_value_name_float(i, "posx", GarageData[id][garagePosX]);
			cache_get_value_name_float(i, "posy", GarageData[id][garagePosY]);
			cache_get_value_name_float(i, "posz", GarageData[id][garagePosZ]);
			cache_get_value_name_int(i, "interior", GarageData[id][garageInt]);
			cache_get_value_name_int(i, "world", GarageData[id][garageWorld]);
            
            Garage_Refresh(id);
            Iter_Add(Garages, id);
	    	i++;
		}
		printf("[Garage]: %d Loaded.", i);
	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_YES ))
	{
		
        foreach(new gid : Garages)
        {
            if(IsPlayerInRangeOfPoint(playerid, 2.5, GarageData[gid][garagePosX], GarageData[gid][garagePosY], GarageData[gid][garagePosZ]))
            {
                if(!Player_OwnsGarage(playerid, gid)) 
                    return Error(playerid, "Kamu bukan pemilik garage ini.");

                pData[playerid][pGarage] = gid;
                ShowPlayerDialog(playerid, DIALOG_GARAGE, DIALOG_STYLE_MSGBOX, "Private Garage ", ">> {FFFF00}ParkVeh: {ffffff}Untuk Memarkir Kendaraanmu.\n>> {FFFF00}PickupVeh: {ffffff}Untuk Mengambil Kendaraanmu.","ParkVeh", "PickupVeh");
            }
        }	
	}
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_GARAGE)
	{
		if(response)
		{
			if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
			if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
			if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be in Vehicle");
			new id = -1;
			id = GetClosestGarage(playerid);

			if(id > -1)
			{
				/*if(CountGarageVeh(id) >= GarageData[pData[playerid][pGarage]][garageSlot])
					return Error(playerid, "Garasi sudah memenuhi Kapasitas!");*/

				new carid = -1,
					found = 0;

				if((carid = Vehicle_Nearest2(playerid)) != -1)
				{

					GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
					GetVehicleZAngle(pvData[carid][cVeh], pvData[carid][cPosA]);
					GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					InfoTD_MSG(playerid, 4000, "Vehicle ~r~Despawned");
					RemovePlayerFromVehicle(playerid);
					pvData[carid][cGarage] = id;					
					SetPlayerArmedWeapon(playerid, 0);
					found++;
					if(IsValidVehicle(pvData[carid][cVeh]))
					{
						DestroyVehicle(pvData[carid][cVeh]);
						pvData[carid][cVeh] = INVALID_VEHICLE_ID;
					}
				}
				if(!found)
					return Error(playerid, "Kendaraan ini tidak dapat di Park!");
			}
			return 1;
		}
		else
		{
			if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
			if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "You must be not in Vehicle");
			foreach(new i : Garages)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.3, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]))
				{
					pData[playerid][pGarage] = i;
					if(GetAnyVehicleGarage(i) <= 0) return Error(playerid, "Tidak ada Kendaraan yang diparkirkan disini.");
					new id, count = GetAnyVehicleGarage(i), location[4080], lstr[596];

					strcat(location,"No\tVehicle\tPlate\n",sizeof(location));
					Loop(itt, (count + 1), 1)
					{
						id = ReturnAnyVehicleGarage(itt, i);
						if(itt == count)
						{
							format(lstr,sizeof(lstr), "%d\t%s\t%s\t%s\n", itt, GetVehicleModelName(pvData[id][cModel]), pvData[id][cPlate]);
						}
						else format(lstr,sizeof(lstr), "%d\t%s\t%s\t%s\n", itt, GetVehicleModelName(pvData[id][cModel]), pvData[id][cPlate]);
						strcat(location,lstr,sizeof(location));
					}
					ShowPlayerDialog(playerid, DIALOG_PICKUPVEH_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Parked Vehicle",location,"Pickup","Cancel");
				}
			}
			return 1;
		}
	}
	if(dialogid == DIALOG_PICKUPVEH_GARAGE)
	{
		if(response)
		{
			new id = ReturnAnyVehicleGarage((listitem + 1), pData[playerid][pGarage]);

			if(pvData[id][cOwner] != pData[playerid][pID]) return Error(playerid, "This is not your Vehicle!");
			pvData[id][cGarage] = -1;
			GetPlayerPos(playerid, pvData[id][cPosX], pvData[id][cPosY], pvData[id][cPosZ]);
			GetPlayerFacingAngle(playerid, pvData[id][cPosA]);
			OnPlayerVehicleRespawn(id);
			InfoTD_MSG(playerid, 4000, "Vehicle ~g~Spawned");
			PutPlayerInVehicle(playerid, pvData[id][cVeh], 0);
		}
	}
    return 1;
}

stock Garage_Refresh(i)
{
    static str[128];
    if(i != -1)
    {
        if(IsValidDynamic3DTextLabel(GarageData[i][garageLabel]))
            DestroyDynamic3DTextLabel(GarageData[i][garageLabel]);

        if(IsValidDynamicPickup(GarageData[i][garagePickup]))
            DestroyDynamicPickup(GarageData[i][garagePickup]);

        if(strcmp(GarageData[i][garageOwner], "-") || GarageData[i][garageOwnerID] != 0)
		{
            format(str, sizeof(str), "[GARAGE ID: %d]\n{ffffff}Owner: {00FF00}%s{FFFFFF}\nPress 'Y' to Parkveh/ PickupVeh", i, GarageData[i][garageOwner]);
        }
        else
        {
            format(str, sizeof(str), "[GARAGE ID: %d]\n{ffffff}Price: {00FF00}%s{FFFFFF}\nType {FFFF00}'/buy' {FFFFFF}to buy", i, FormatMoney(GarageData[i][garagePrice]));
        }
        GarageData[i][garagePickup] = CreateDynamicPickup(19134, 23, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ], GarageData[i][garageWorld],  GarageData[i][garageInt], -1, 50);
		GarageData[i][garageLabel] = CreateDynamic3DTextLabel(str, ARWIN, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GarageData[i][garageWorld], GarageData[i][garageInt], -1, 10.0);
    }
    return 1;
}

stock Garage_Save(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE garage SET owner='%s', ownerid='%d', price='%d', posx='%f', posy='%f', posz='%f', interior=%d, world=%d WHERE id=%d",
	GarageData[id][garageOwner],
    GarageData[id][garageOwnerID],
    GarageData[id][garagePrice],
    GarageData[id][garagePosX],
	GarageData[id][garagePosY],
	GarageData[id][garagePosZ],
	GarageData[id][garageInt],
	GarageData[id][garageWorld],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}


stock GetClosestGarage(playerid, Float: range = 4.3)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach(new i : Garages)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]);

	    if(tempdist > range) continue;
		if(tempdist <= dist && GetPlayerInterior(playerid) == GarageData[i][garageInt] && GetPlayerVirtualWorld(playerid) == GarageData[i][garageWorld])
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

stock ReturnAnyVehicleGarage(slot, i)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_PRIVATE_VEHICLE) return -1;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cGarage] == i && pvData[id][cGarage] > -1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

stock CountGarageVeh(id)
{
	if(id > -1)
	{
		new count = 0;
		foreach(new i : PVehicles)
		{
			if(pvData[i][cGarage] == id)
				count++;
		}
		return count;
	}
	return 0;
}

stock GetAnyVehicleGarage(i)
{
	new tmpcount;
	foreach(new id : PVehicles)
	{
	    if(pvData[id][cGarage] == i)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

stock GetNearbyGarage(playerid)
{
	for(new i = 0; i < MAX_GARAGE; i ++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, GarageData[i][garagePosX], GarageData[i][garagePosY], GarageData[i][garagePosZ]))
	    {
	        return i;
	    }
	}
	return -1;
}

stock Player_OwnsGarage(playerid, id)
{
	return (GarageData[id][garageOwnerID] == pData[playerid][pID]) || (!strcmp(GarageData[id][garageOwner], pData[playerid][pName], true));
}


CMD:creategarage(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
		
	new id = Iter_Free(Garages), query[512];
	if(id == -1) return Error(playerid, "Can't add any more garage Point.");
    new price;
    if(sscanf(params, "d", price))   return Usage(playerid, "/creategarage [price]");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);
	
    format(GarageData[id][garageOwner], 128, "-");
    GarageData[id][garageOwnerID] = 0;
    GarageData[id][garagePrice] = price;
	GarageData[id][garagePosX] = x;
	GarageData[id][garagePosY] = y;
	GarageData[id][garagePosZ] = z;
	GarageData[id][garageInt] = GetPlayerInterior(playerid);
	GarageData[id][garageWorld] = GetPlayerVirtualWorld(playerid);
	
	Garage_Refresh(id);
	Iter_Add(Garages, id);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO garage SET id='%d', owner='%s', ownerid='%d', price='%d', posx='%f', posy='%f', posz='%f', interior=%d, world=%d", id, GarageData[id][garageOwner], GarageData[id][garageOwnerID], GarageData[id][garagePrice], GarageData[id][garagePosX], GarageData[id][garagePosY], GarageData[id][garagePosZ], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query, "OnGarageCreated", "ii", playerid, id);
	return 1;
}

function OnGarageCreated(playerid, id)
{
	Garage_Save(id);
	Servers(playerid, "You has created garage Point id: %d.", id);
	return 1;
}

CMD:removegarage(playerid, params[])
{
    if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
		
	new id, query[512];
	if(sscanf(params, "i", id)) return Usage(playerid, "/removegarage [id]");
	if(!Iter_Contains(Garages, id)) return Error(playerid, "Invalid ID.");
	
	DestroyDynamic3DTextLabel(GarageData[id][garageLabel]);
	DestroyDynamicPickup(GarageData[id][garagePickup]);
	
    GarageData[id][garagePrice] = 0;
	GarageData[id][garagePosX] = GarageData[id][garagePosY] = GarageData[id][garagePosZ] = 0.0;
	GarageData[id][garageInt] = GarageData[id][garageWorld] = 0;
	GarageData[id][garagePickup] = -1;
	GarageData[id][garageLabel] = Text3D: -1;
	Iter_Remove(Garages, id);
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM parks WHERE id=%d", id);
	mysql_tquery(g_SQL, query);
	Servers(playerid, "Menghapus ID Garage Point %d.", id);
	return 1;
}

CMD:gotogarage(playerid, params[])
{
	new id;
	if(pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);
		
	if(sscanf(params, "d", id))
		return Usage(playerid, "/gotogarage [id]");
	if(!Iter_Contains(Garages, id)) return Error(playerid, "Garage Point ID tidak ada.");
	
	SetPlayerPosition(playerid, GarageData[id][garagePosX], GarageData[id][garagePosY], GarageData[id][garagePosZ], 2.0);
    SetPlayerInterior(playerid, GarageData[id][garageInt]);
    SetPlayerVirtualWorld(playerid, GarageData[id][garageWorld]);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	Servers(playerid, "Teleport ke ID Garage Point %d", id);
	return 1;
}

CMD:editgarage(playerid, params[])
{
    static
        gid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", gid, type, string))
    {
        Usage(playerid, "/editgarage [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, slot, owner, price");
        return 1;
    }
    if((gid < 0 || gid >= MAX_GARAGE))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Garages, gid)) return Error(playerid, "The garage you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, GarageData[gid][garagePosX], GarageData[gid][garagePosY], GarageData[gid][garagePosZ]);
        GarageData[gid][garageInt] = GetPlayerInterior(playerid);
        GarageData[gid][garageWorld] = GetPlayerVirtualWorld(playerid);

        Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the location of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/editgarage [id] [price] [ammount]");

		GarageData[gid][garagePrice] = price;

        Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the price of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    else if(!strcmp(type, "owner", true))
    {
        new otherid;

        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/editgarage [id] [owner] [playerid]");
        
        format(GarageData[gid][garageOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
		GarageData[gid][garageOwnerID] = pData[otherid][pID];

		Garage_Refresh(gid);
        Garage_Save(gid);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of garage ID: %d.", pData[playerid][pAdminname], gid);
    }
    return 1;
}
