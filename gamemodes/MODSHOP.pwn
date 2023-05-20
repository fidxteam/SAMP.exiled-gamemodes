#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
    Player_EditVehicleObject[playerid] = -1;
    Player_EditVehicleObjectSlot[playerid] = -1;
    Player_EditingObject[playerid] = 0;
}

hook OnGameModeInit()
{
    for (new i; i < sizeof(ColorList); i++) {
    format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 16 == 0) ? ("\n") : (""));
    }

    for (new i; i < sizeof(FontNames); i++) {
        format(object_font, sizeof(object_font), "%s%s\n", object_font, FontNames[i]);
    }
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
    if((response) && (extraid == Transfender))
    {
		if(response)
	    {
            new
            price = 5000,
            vehicleid
            ;

            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                 return Error(playerid, "You need to be inside vehicle as driver");

            vehicleid = Vehicle_Nearest(playerid);

            if(vehicleid == -1)
                 return 0;

            Vehicle_ObjectAddObjects(playerid, vehicleid, modelid, OBJECT_TYPE_BODY);

            SendClientMessageEx(playerid, ARWIN,"MODSHOP: "WHITE_E"You have purchased a {00FFFF}%s "WHITE_E"for "GREEN_E"$%s.", GetVehObjectNameByModel(modelid), FormatMoney(price));
        }
	}
	if((response) && (extraid == Loco))
    {
		if(response)
	    {
            new
            price = 5000,
            vehicleid
            ;

            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                return Error(playerid, "You need to be inside vehicle as driver");

            vehicleid = Vehicle_Nearest(playerid);

            if(vehicleid == -1)
                 return 0;

            Vehicle_ObjectAddObjects(playerid, vehicleid, modelid, OBJECT_TYPE_BODY);

            SendClientMessageEx(playerid, ARWIN,"MODSHOP: "WHITE_E"You have purchased a {00FFFF}%s "WHITE_E"for "GREEN_E"$%s.", GetVehObjectNameByModel(modelid), FormatMoney(price));
        }
	}
	if((response) && (extraid == Waa))
    {
		if(response)
	    {
            new
            price = 5000,
            vehicleid
            ;

            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                return Error(playerid, "You need to be inside vehicle as driver");

            vehicleid = Vehicle_Nearest(playerid);

            if(vehicleid == -1)
                return 0;

            Vehicle_ObjectAddObjects(playerid, vehicleid, modelid, OBJECT_TYPE_BODY);

            SendClientMessageEx(playerid, ARWIN,"MODSHOP: "WHITE_E"You have purchased a {00FFFF}%s "WHITE_E"for "GREEN_E"$%s.", GetVehObjectNameByModel(modelid), FormatMoney(price));
        }
	}
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_MODSHOP)
	{
		if(response)
		{
			switch (listitem)
			{
				case 0:
				{
					ShowModeleSelectionMenu(playerid, "MODSHOP", Transfender, transfender, sizeof(transfender), -16.0, 0.0, -55.0);
				}

				case 1:
				{
					ShowModeleSelectionMenu(playerid, "MODSHOP", Waa, waa, sizeof(waa), -16.0, 0.0, -55.0);
				}

				case 2:
				{
					ShowModeleSelectionMenu(playerid, "MODSHOP", Loco, loco, sizeof(loco), -16.0, 0.0, -55.0);
				}
				
				case 3:
				{
				    static 
				        vehicle;
				    
				    vehicle = Vehicle_Nearest(playerid);
				    if(vehicle != INVALID_VEHICLE_ID) 
				    {
				    	Vehicle_TextAdd(playerid, vehicle, 18661, OBJECT_TYPE_TEXT);
				    	return 1;
				    } 
				    else Error(playerid, "Invalid vehicle id.");
				    
				}
				case 4:
				{
				    static 
				        vehicle;
				    
				    vehicle = Vehicle_Nearest(playerid);
				    if(vehicle != INVALID_VEHICLE_ID) 
				    {
				    	Vehicle_SpotLightAdd(playerid, vehicle, 19281, OBJECT_TYPE_LIGHT);
				    	return 1;
				    } 
				    else Error(playerid, "Invalid vehicle id.");
				    
				}
			}
		}
		return 1;
	}
	if(dialogid == EditingVehObject)
	{
		if(response)
		{
			Player_EditVehicleObjectSlot[playerid] = ListedVehObject[playerid][listitem];
			new vehicleid = Player_EditVehicleObject[playerid];
			if(!VehicleObjects[vehicleid][Player_EditVehicleObjectSlot[playerid]][vehObjectExists])
			{
				ShowPlayerDialog(playerid, DIALOG_MODSHOP, DIALOG_STYLE_LIST, "Buying Modification", "Transfender Component\nWAA Component\nLoco Component\nSticker\nSpot Light", "Okay", "Cancel");
			}
			else
			{
				new 
					slot = Player_EditVehicleObjectSlot[playerid]
				;
				if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
				{
					ShowPlayerDialog(playerid, VACCSE, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nChange Color\nRemove Modification\nSave", "Select", "Back");
				}
				else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
				{
					ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
				}
				else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
				{
				ShowPlayerDialog(playerid, VACCSE2, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nRemove Modification\nSave", "Select", "Back");
				}
			}
		}
		return 1;
	}

	if(dialogid == VACCSE)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid],
				modelid = VehicleObjects[vehicleid][slot][vehObjectModel]
			;

			switch(listitem)
			{
				case 0:
				{
					if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);

						Vehicle_ObjectEdit(playerid, vehicleid, slot);
						EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
					else
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);
						Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
				}
				case 1:
				{
					new string[512];
					format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
					VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
					VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_COLOR, DIALOG_STYLE_INPUT, "Modification Color", color_string, "Select", "Close");
				}
				case 3:
				{
					Vehicle_ObjectDelete(vehicleid, slot);
					SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You removed "YELLOW_E"%s "WHITE_E"from your vehicle!", GetVehObjectNameByModel(modelid));
				}
				case 4:
				{
					Vehicle_ObjectSave(vehicleid, slot);
					callcmd::myov(playerid, "");
					GivePlayerMoneyEx(playerid, -5000);
				}
			}
		}
		return 1;
	}

	if(dialogid == VACCSE1)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			switch(listitem)
			{
				case 0:
				{
					if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);

						Vehicle_ObjectEdit(playerid, vehicleid, slot);
						EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
					else
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);
						Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
				}
				case 1:
				{
					new string[512];
					format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
					VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
					VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Input Text name 32 Character : ", "Update", "Close");
				}
				case 3:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", "Input Text Size Maximal Ukuran 200 : ", "Update", "Close");
				}
				case 4:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_LIST, "Input Text Font", object_font, "Update", "Close");
				}
				case 5:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTCOLOR, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
				}
				case 6:
				{
					Vehicle_ObjectDelete(vehicleid, slot);
					SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You removed vehicle text object!");
				}
				case 7:
				{
					Vehicle_ObjectSave(vehicleid, slot);
					callcmd::myov(playerid, "");
					GivePlayerMoneyEx(playerid, -5000);
				}
			}
		}
		return 1;
	}

	if(dialogid == VACCSE2)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid],
				modelid = VehicleObjects[vehicleid][slot][vehObjectModel]
			;

			switch(listitem)
			{
				case 0:
				{
					if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
					{
						Vehicle_ObjectEdit(playerid, vehicleid, slot);
						EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
					else
					{
						Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
				}
				case 1:
				{
					new string[512];
					format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
					VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
					VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
				}
				case 2:
				{
					Vehicle_ObjectDelete(vehicleid, slot);
					SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You removed "YELLOW_E"%s "WHITE_E"from your vehicle!", GetVehObjectNameByModel(modelid));
				}
				case 3:
				{
					Vehicle_ObjectSave(vehicleid, slot);
					callcmd::myov(playerid, "");
					GivePlayerMoneyEx(playerid, -5000);
				}
			}
		}
		return 1;
	}

	if(dialogid == VEH_OBJECT_COLOR)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;

			VehicleObjects[vehicleid][slot][vehObjectColor] = strval(inputtext);
			Vehicle_ObjectColorSync(vehicleid, slot);
			ShowPlayerDialog(playerid, VACCSE, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nChange Color\nRemove Modification\nSave", "Select", "Back");
		}
		return 1;
	}

	if(dialogid == VEH_OBJECT_TEXT)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Input Text name 32 Character : ", "Update", "Close");
				}
				case 1:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", "Input Text Size Maximal Ukuran 200 : ", "Update", "Close");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_LIST, "Input Text Font", object_font, "Update", "Close");
				}
				case 3:
				{
					ShowPlayerDialog(playerid, VEH_OBJECT_TEXTCOLOR, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
				}
			}
		}
		return 1;
	}

	if(dialogid == DIALOG_MODSHOPMOVE)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			switch(listitem)
			{
				case 0:
				{
					if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);

						Vehicle_ObjectEdit(playerid, vehicleid, slot);
						EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
					else
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);
						Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
				}
				case 1:
				{
					new string[512];
					format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
					VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
					VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
				}
			}
		}
		return 1;
	}

	if(dialogid == DIALOG_SPOTLIGHT)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			switch(listitem)
			{
				case 0:
				{
					if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);

						Vehicle_ObjectEdit(playerid, vehicleid, slot);
						EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
					else
					{
						SetVehicleZAngle(GetPlayerVehicleID(playerid), 0.0);
						Vehicle_ObjectEdit(playerid, vehicleid, slot, true);
						SendClientMessageEx(playerid, ARWIN, "MODSHOP: "WHITE_E"You can now edit the location for the mod");
					}
				}
				case 1:
				{
					new string[512];
					format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
					VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
					VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, DIALOG_SPOTLIGHT1, DIALOG_STYLE_LIST, "Light Color", "White\nRed\nGreen\nBlue", "Select", "Cancel"); 
				}
				case 3:
				{
					Vehicle_ObjectSave(vehicleid, slot);
					callcmd::myov(playerid, "");
					GivePlayerMoneyEx(playerid, -5000);
				}
			}
		}
		return 1;
	}

	if(dialogid == DIALOG_SPOTLIGHT1)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			switch(listitem)
			{
				case 0:
				{
					Vehicle_LightColorSync(vehicleid, slot, 19281, playerid);
				}
				case 1:
				{
					Vehicle_LightColorSync(vehicleid, slot, 19282, playerid);
				}
				case 2:
				{
					Vehicle_LightColorSync(vehicleid, slot, 19283, playerid);
				}
				case 3:
				{
					Vehicle_LightColorSync(vehicleid, slot, 19284, playerid);
				}
			}
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDIT)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;
			switch(listitem)
			{
				case 0: //X
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current PosX: %f\nInput new PosX:(Float)", VehicleObjects[vehicleid][slot][vehObjectPosX]);
					ShowPlayerDialog(playerid, DIALOG_MSEDITX, DIALOG_STYLE_INPUT, "PosX", mstr, "Edit", "Cancel");
				}
				case 1: //Y
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current PosX: %f\nInput new PosY:(Float)", VehicleObjects[vehicleid][slot][vehObjectPosY]);
					ShowPlayerDialog(playerid, DIALOG_MSEDITY, DIALOG_STYLE_INPUT, "PosY", mstr, "Edit", "Cancel");
				}
				case 2: //Z
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current PosX: %f\nInput new PosZ:(Float)", VehicleObjects[vehicleid][slot][vehObjectPosZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDITZ, DIALOG_STYLE_INPUT, "PosZ", mstr, "Edit", "Cancel");
				}
				case 3: //RX
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current PosX: %f\nInput new PosRX:(Float)", VehicleObjects[vehicleid][slot][vehObjectPosRX]);
					ShowPlayerDialog(playerid, DIALOG_MSEDITRX, DIALOG_STYLE_INPUT, "PosRX", mstr, "Edit", "Cancel");
				}
				case 4: //RY
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current PosX: %f\nInput new PosRY:(Float)", VehicleObjects[vehicleid][slot][vehObjectPosRY]);
					ShowPlayerDialog(playerid, DIALOG_MSEDITRY, DIALOG_STYLE_INPUT, "PosRY", mstr, "Edit", "Cancel");
				}
				case 5: //RZ
				{
					new mstr[128];
					format(mstr, sizeof(mstr), ""WHITE_E"Current PosX: %f\nInput new PosRZ:(Float)", VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
					ShowPlayerDialog(playerid, DIALOG_MSEDITRZ, DIALOG_STYLE_INPUT, "PosRZ", mstr, "Edit", "Cancel");
				}
			}
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDITX)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;
			new Float:posisi = floatstr(inputtext);
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], 
			posisi, 
			VehicleObjects[vehicleid][slot][vehObjectPosY], 
			VehicleObjects[vehicleid][slot][vehObjectPosZ], 
			VehicleObjects[vehicleid][slot][vehObjectPosRX], 
			VehicleObjects[vehicleid][slot][vehObjectPosRY], 
			VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			//Vehicle_ObjectSave(vehicleid, slot);

			VehicleObjects[vehicleid][slot][vehObjectPosX] = posisi;
			new string[512];
			format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
			VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDITY)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;
			new Float:posisi = floatstr(inputtext);
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], 
			VehicleObjects[vehicleid][slot][vehObjectPosX], 
			posisi, 
			VehicleObjects[vehicleid][slot][vehObjectPosZ], 
			VehicleObjects[vehicleid][slot][vehObjectPosRX], 
			VehicleObjects[vehicleid][slot][vehObjectPosRY], 
			VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			

			VehicleObjects[vehicleid][slot][vehObjectPosY] = posisi;
			new string[512];
			format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
			VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDITZ)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;
			new Float:posisi = floatstr(inputtext);
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], 
			VehicleObjects[vehicleid][slot][vehObjectPosX], 
			VehicleObjects[vehicleid][slot][vehObjectPosY], 
			posisi, 
			VehicleObjects[vehicleid][slot][vehObjectPosRX], 
			VehicleObjects[vehicleid][slot][vehObjectPosRY], 
			VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			

			VehicleObjects[vehicleid][slot][vehObjectPosZ] = posisi;
			new string[512];
			format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
			VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDITRX)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;
			new Float:posisi = floatstr(inputtext);
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], 
			VehicleObjects[vehicleid][slot][vehObjectPosX], 
			VehicleObjects[vehicleid][slot][vehObjectPosY], 
			VehicleObjects[vehicleid][slot][vehObjectPosZ], 
			posisi, 
			VehicleObjects[vehicleid][slot][vehObjectPosRY], 
			VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			

			VehicleObjects[vehicleid][slot][vehObjectPosRX] = posisi;
			new string[512];
			format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
			VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDITRY)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;
			new Float:posisi = floatstr(inputtext);
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], 
			VehicleObjects[vehicleid][slot][vehObjectPosX], 
			VehicleObjects[vehicleid][slot][vehObjectPosY], 
			VehicleObjects[vehicleid][slot][vehObjectPosZ], 
			VehicleObjects[vehicleid][slot][vehObjectPosRX], 
			posisi, 
			VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			

			VehicleObjects[vehicleid][slot][vehObjectPosRY] = posisi;
			new string[512];
			format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
			VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
		}
		return 1;
	}

	if(dialogid == DIALOG_MSEDITRZ)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;
			new Float:posisi = floatstr(inputtext);
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], 
			VehicleObjects[vehicleid][slot][vehObjectPosX], 
			VehicleObjects[vehicleid][slot][vehObjectPosY], 
			VehicleObjects[vehicleid][slot][vehObjectPosZ], 
			VehicleObjects[vehicleid][slot][vehObjectPosRX], 
			VehicleObjects[vehicleid][slot][vehObjectPosRY], 
			posisi);
			

			VehicleObjects[vehicleid][slot][vehObjectPosRZ] = posisi;
			new string[512];
			format(string, sizeof(string), "PosX: %f\nPosY: %f\nPosZ: %f\nPosRX: %f\nPosRY: %f\nPosRZ: %f",
			VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ],
			VehicleObjects[vehicleid][slot][vehObjectPosRX], VehicleObjects[vehicleid][slot][vehObjectPosRY], VehicleObjects[vehicleid][slot][vehObjectPosRZ]);
			ShowPlayerDialog(playerid, DIALOG_MSEDIT, DIALOG_STYLE_LIST, "Modshop", string, "Select", "Cancel");
		}
		return 1;
	}

	if(dialogid == VEH_OBJECT_TEXTNAME)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			if(isnull(inputtext))
				return ShowPlayerDialog(playerid, VEH_OBJECT_TEXTNAME, DIALOG_STYLE_INPUT, "Input Text Name", "Error : Text tidak boleh kosong\n\nInput Text name 32 Character : ", "Select", "Close");

			format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "%s", inputtext);
			Vehicle_ObjectTextSync(vehicleid, slot);
			ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
			
		}
		return 1;
	}
	if(dialogid == VEH_OBJECT_TEXTCOLOR)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]        
			;

			if(!(0 <= strval(inputtext) <= sizeof(ColorList)-1))
				return ShowPlayerDialog(playerid, VEH_OBJECT_TEXTFONT, DIALOG_STYLE_INPUT, "Input Text Color", color_string, "Update", "Close");
			
			VehicleObjects[vehicleid][slot][vehObjectFontColor] = strval(inputtext);
			Vehicle_ObjectTextSync(vehicleid, slot);
			ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
		}
		return 1;
	}
	if(dialogid == VEH_OBJECT_TEXTSIZE)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			if(!(0 < strval(inputtext) <= 200))
				return ShowPlayerDialog(playerid, VEH_OBJECT_TEXTSIZE, DIALOG_STYLE_INPUT, "Input Text Size", "Error: ukuran dibatasi mulai dari 1 sampai 200\n\nMasukkan ukuran font mulai dari angka 1 sampai 200 :", "Update", "Back");

			VehicleObjects[vehicleid][slot][vehObjectFontSize] = strval(inputtext);
			Vehicle_ObjectTextSync(vehicleid, slot);
			ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
		}
		return 1;
	}

	if(dialogid == VEH_OBJECT_TEXTFONT)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;

			if(listitem == sizeof(FontNames) - 1)
				return ShowPlayerDialog(playerid, VEH_OBJECT_FONTCUSTOM, DIALOG_STYLE_INPUT, "Input Text Font - Custom Font", "Masukkan nama font yang akan kamu ubah:", "Input", "Back");

			format(VehicleObjects[vehicleid][slot][vehObjectFont], 32, "%s", inputtext);
			Vehicle_ObjectTextSync(vehicleid, slot);
			ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
		}
		return 1;
	}
	if(dialogid == VEH_OBJECT_FONTCUSTOM)
	{
		if(response)
		{
			new 
				slot = Player_EditVehicleObjectSlot[playerid],
				vehicleid = Player_EditVehicleObject[playerid]
			;
			if(!strlen(inputtext))
				return ShowPlayerDialog(playerid, VEH_OBJECT_FONTCUSTOM, DIALOG_STYLE_INPUT, "Input Text Font - Custom Font", "Error : nama font tidak boleh kosong!\n\nMasukkan nama font yang akan kamu ubah\nPastikan nama font benar!:", "Input", "Back");

			format(VehicleObjects[vehicleid][slot][vehObjectFont], 32, "%s", inputtext);
			Vehicle_ObjectTextSync(vehicleid, slot);
			ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
		}
		return 1;
	}	
    return 1;
}

// Function ini untuk save object kendaraan ke database dan menyimpan SQL id ke dalam vehObjectID!
forward Vehicle_ObjectDB(vehicleid, slot);
public Vehicle_ObjectDB(vehicleid, slot)
{
	if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
		return 0;

	VehicleObjects[vehicleid][slot][vehObjectID] = cache_insert_id();


	Vehicle_ObjectSave(vehicleid, slot);
	return 1;
}

// Function untuk ngeload object kendaraan ketika kendraan diload ke dalam server!
forward Vehicle_ObjectLoaded(vehicleid, playerid);
public Vehicle_ObjectLoaded(vehicleid, playerid)
{
	if(cache_num_rows())
	{
		for(new slot = 0; slot != cache_num_rows(); slot++)
        { 
            if(!VehicleObjects[vehicleid][slot][vehObjectExists])
            {
                // Load semua data yang ada di Mysql dan di simpan ke dalam variabel, untuk di tampung
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                cache_get_value_name(slot, "text", VehicleObjects[vehicleid][slot][vehObjectText], 32);
                cache_get_value_name(slot, "font", VehicleObjects[vehicleid][slot][vehObjectFont], 32);			

                cache_get_value_name_int(slot, "id", VehicleObjects[vehicleid][slot][vehObjectID]);
                cache_get_value_name_int(slot, "vehicle", VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]);
                cache_get_value_name_int(slot, "type", VehicleObjects[vehicleid][slot][vehObjectType]);
                cache_get_value_name_int(slot, "model", VehicleObjects[vehicleid][slot][vehObjectModel]);
				cache_get_value_name_int(slot, "color", VehicleObjects[vehicleid][slot][vehObjectColor]);

                cache_get_value_name_int(slot, "fontcolor", VehicleObjects[vehicleid][slot][vehObjectFontColor]);
                cache_get_value_name_int(slot, "fontsize", VehicleObjects[vehicleid][slot][vehObjectFontSize]);

                cache_get_value_name_float(slot, "x", VehicleObjects[vehicleid][slot][vehObjectPosX]);
                cache_get_value_name_float(slot, "y", VehicleObjects[vehicleid][slot][vehObjectPosY]);
                cache_get_value_name_float(slot, "z", VehicleObjects[vehicleid][slot][vehObjectPosZ]);

                cache_get_value_name_float(slot, "rx", VehicleObjects[vehicleid][slot][vehObjectPosRX]);
                cache_get_value_name_float(slot, "ry", VehicleObjects[vehicleid][slot][vehObjectPosRY]);
                cache_get_value_name_float(slot, "rz", VehicleObjects[vehicleid][slot][vehObjectPosRZ]);

                // Ketika sudah terload, maka object yang sudah di tampung ke dalam variabel akan di attach berdasarkan slotnya!
                Vehicle_AttachObject(vehicleid, slot);
            }
        }
	}
	return 1;
}

// Function untuk ngesave object ke dalam database dari variabel penampung!
Vehicle_ObjectSave(vehicleid, slot)
{
	if(VehicleObjects[vehicleid][slot][vehObjectExists])
    {
        new query[1024];

        format(query, sizeof(query), "UPDATE `vehicle_object` SET `model`='%d', `color`='%d',`type`='%d', `x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f'",
            VehicleObjects[vehicleid][slot][vehObjectModel],
            VehicleObjects[vehicleid][slot][vehObjectColor],
            VehicleObjects[vehicleid][slot][vehObjectType],
            VehicleObjects[vehicleid][slot][vehObjectPosX], 
            VehicleObjects[vehicleid][slot][vehObjectPosY], 
            VehicleObjects[vehicleid][slot][vehObjectPosZ], 
            VehicleObjects[vehicleid][slot][vehObjectPosRX],
            VehicleObjects[vehicleid][slot][vehObjectPosRY], 
            VehicleObjects[vehicleid][slot][vehObjectPosRZ]
        );

        format(query, sizeof(query), "%s, `text`='%s',`font`='%s', `fontsize`='%d',`fontcolor`='%d' WHERE `id`='%d' AND `vehicle` = '%d'",
            query, 
            VehicleObjects[vehicleid][slot][vehObjectText], 
            VehicleObjects[vehicleid][slot][vehObjectFont], 
            VehicleObjects[vehicleid][slot][vehObjectFontSize], 
            VehicleObjects[vehicleid][slot][vehObjectFontColor], 
            VehicleObjects[vehicleid][slot][vehObjectID],
			VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]
        );
        mysql_tquery(g_SQL, query);
    }
	return 1;
}

// Function untuk menambahkan object untuk vehicle id tersebut
// Model = Object modelnya || Type = 1 / 2, 1 Itu Object, 2 Itu Text
Vehicle_ObjectAddObjects(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT) //
                {
                    format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "TEXT");
                    format(VehicleObjects[vehicleid][slot][vehObjectFont], 24, "Arial");
                    VehicleObjects[vehicleid][slot][vehObjectFontColor] = 1;
                    VehicleObjects[vehicleid][slot][vehObjectFontSize] = 24; 
                }

                ShowPlayerDialog(playerid, DIALOG_MODSHOPMOVE, DIALOG_STYLE_LIST, "Modshop", "Position\nPosition (Manual)", "Select", "Close");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$50.00", GetVehObjectNameByModel(VehicleObjects[vehicleid][slot][vehObjectModel]));
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

Vehicle_TextAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT) //
                {
                    format(VehicleObjects[vehicleid][slot][vehObjectText], 32, "TEXT");
                    format(VehicleObjects[vehicleid][slot][vehObjectFont], 24, "Arial");
                    VehicleObjects[vehicleid][slot][vehObjectFontColor] = 1;
                    VehicleObjects[vehicleid][slot][vehObjectFontSize] = 24; 
                }

                ShowPlayerDialog(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification", "Select", "Back");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}Sticker {ffffff}for {00ff00}$50.00");
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

Vehicle_SpotLightAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                if(GetPlayerMoney(playerid) < 5000)
	  			    return Error(playerid, "Untuk membeli vehicle toys kamu harus mempunyai uang $50.00");
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                ShowPlayerDialog(playerid, DIALOG_SPOTLIGHT, DIALOG_STYLE_LIST, "Modshop", "Position\nPosition (Manual)\nLight Color", "Select", "Close");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}SpotLight {ffffff}for {00ff00}$50.00");
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

// Function untuk attach vehicle object ke kendaraan yang sudah ada di server!
Vehicle_AttachObject(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        new
            model       = VehicleObjects[vehicleid][slot][vehObjectModel],
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
            Float:vposx,
            Float:vposy,
            Float:vposz
        ;

        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

        GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

        if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
        {
            Vehicle_ObjectColorSync(vehicleid, slot);
        }
        else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
        {
            Vehicle_ObjectTextSync(vehicleid, slot);
        }
        else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
        {
            Vehicle_SpotLightDelete(vehicleid, slot);
        }
        AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
        Vehicle_ObjectUpdate(vehicleid, slot);
        return 1;
    }
    return 0;
}

// Function Untuk sync object color yang ada di kendaraan, ketika mengubah warna object!
Vehicle_SpotLightDelete(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        switch(GetLightStatus(vehicleid))
		{
			case false:
			{
                if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                    DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);
			}
			case true:
			{
                new
                    model       = VehicleObjects[vehicleid][slot][vehObjectModel],
                    Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
                    Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
                    Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
                    Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
                    Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
                    Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
                    Float:vposx,
                    Float:vposy,
                    Float:vposz
                ;
                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
                {
                    if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                    DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

                    VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

                    GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

                    VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

                    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
                    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

                    AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
                    Vehicle_ObjectUpdate(vehicleid, slot);
                }
			}
		}
        return 1;
    }
    return 0;
}

// Function Untuk sync object color yang ada di kendaraan, ketika mengubah warna object!
Vehicle_ObjectColorSync(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        SetDynamicObjectMaterial(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectModel], "none", "none", RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectColor]]));
        return 1;
    }
    return 0;
}

// Function Untuk sync object color yang ada di kendaraan, ketika mengubah warna object!
Vehicle_LightColorSync(vehicleid, slot, id, playerid)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        new
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
            Float:vposx,
            Float:vposy,
            Float:vposz
        ;
        VehicleObjects[vehicleid][slot][vehObjectModel] = id;
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);


        GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);
        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;
        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(VehicleObjects[vehicleid][slot][vehObjectModel], vposx+x, vposy+y, vposz+z, rx, ry, rz);   
        
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 15);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 15);
        //Vehicle_ObjectSave(vehicleid, slot); // Setelah warna di ubah pastikan selalu di save!
        ShowPlayerDialog(playerid, DIALOG_SPOTLIGHT, DIALOG_STYLE_LIST, "Modshop", "Position\nPosition (Manual)\nLight Color\nSave", "Select", "Close");
	    return 1;
    }
    return 0;
}

// Function untuk sync text yang ada di kendaraan ketika mengubah text!
Vehicle_ObjectTextSync(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectText], 130, VehicleObjects[vehicleid][slot][vehObjectFont], VehicleObjects[vehicleid][slot][vehObjectFontSize], 1, RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectFontColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
        return 1;
    }
    return 0;
}

// Function ini berguna untuk update posisi object ke dalam variabel setelah di edit menggunakan
// ..- Callback OnPlayerEditDynamicObject!
Vehicle_ObjectUpdate(vehicleid, slot)
{   
	if(Iter_Contains(PVehicles, vehicleid))
	{
        new
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ]
        ;

        // Streamer SetFloatData ini berguna untuk memanipulasi data object float yang ada di object streamer dari variabel yang tersimpan
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_X, x);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_Y, y);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_Z, z);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_R_X, rx);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_R_Y, ry);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_R_Z, rz);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);
        return 1;
    }
    return 0;
}

// Function ini berguna untuk menghapus object pada kendaraan, berdasarkan slot!
Vehicle_ObjectDelete(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        new query_string[255];
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        VehicleObjects[vehicleid][slot ][vehObject] = INVALID_OBJECT_ID;

        VehicleObjects[vehicleid][slot][vehObjectModel] = 0;
        VehicleObjects[vehicleid][slot][vehObjectExists] = false;

        VehicleObjects[vehicleid][slot][vehObjectColor] = 0;


        VehicleObjects[vehicleid][slot][vehObjectPosX] = VehicleObjects[vehicleid][slot][vehObjectPosY] = VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;
        VehicleObjects[vehicleid][slot][vehObjectPosRX] = VehicleObjects[vehicleid][slot][vehObjectPosRY] = VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;
        format(query_string, sizeof(query_string), "DELETE FROM `vehicle_object` WHERE `id` = '%d'", VehicleObjects[vehicleid][slot][vehObjectID]);
        mysql_tquery(g_SQL, query_string);
        return 1;
    }
    return 0;
}

// Function ini berguna untuk menghapus object pada kendaraan secara keseluruhan!
Vehicle_ObjectDestroy(vehicleid)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        {
            //Jika objectnya valid, maka object akan di hapus!
            if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

            VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

            VehicleObjects[vehicleid][slot][vehObjectModel] = 0;
            VehicleObjects[vehicleid][slot][vehObjectExists] = false;

            VehicleObjects[vehicleid][slot][vehObjectColor] = 1;

            VehicleObjects[vehicleid][slot][vehObjectPosX] = VehicleObjects[vehicleid][slot][vehObjectPosY] = VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;
            VehicleObjects[vehicleid][slot][vehObjectPosRX] = VehicleObjects[vehicleid][slot][vehObjectPosRY] = VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;
        }
        return 1;
    }
    return 0;
}

// Function ini berguna dan akan terpanggil ketika kita "ingin" meng-edit kordinat dari object kita ke kendaraan.
Vehicle_ObjectEdit(playerid, vehicleid, slot, bool:text = false)
{
	if(Iter_Contains(PVehicles, vehicleid))
	{
        new
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
            Float:vposx,
            Float:vposy,
            Float:vposz
        ;
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);
        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;
        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(VehicleObjects[vehicleid][slot][vehObjectModel], vposx+x, vposy+y, vposz+z, rx, ry, rz);   

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 15);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 15);
        Player_EditVehicleObject[playerid] = vehicleid;
        Player_EditVehicleObjectSlot[playerid] = slot;
        Player_EditingObject[playerid] = 1;
        if(text) 
        {
            Vehicle_ObjectTextSync(vehicleid, slot);
        }
        EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
        return 1;
    }
    return 0;
}

// Function ini akan terpanggil ketika cancel editing object
ResetEditing(playerid)
{
    if(Player_EditingObject[playerid])
    {
        if(Player_EditVehicleObject[playerid] != -1 && Player_EditVehicleObjectSlot[playerid] != -1){
            Vehicle_AttachObject(Player_EditVehicleObject[playerid], Player_EditVehicleObjectSlot[playerid]);
            Vehicle_ObjectUpdate(Player_EditVehicleObject[playerid], Player_EditVehicleObjectSlot[playerid]);
            
            Player_EditVehicleObject[playerid] = -1;
            Player_EditVehicleObjectSlot[playerid] = -1;
        }
    }
    Player_EditingObject[playerid] = 0;
    return 1;
}

GetVehObjectNameByModel(model)
{
    new
        name[32];

    for (new i = 0; i < sizeof(VehObject); i ++) 
    if(VehObject[i][Model] == model) 
    {
        strcat(name, VehObject[i][Name]);
        break;
    }
    return name;
}

CMD:myov(playerid, params[])
{
    new 
		vehid,
        string[1024],
        count
	;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return Error(playerid, "You're not driving any vehicle!");

	vehid = Vehicle_Nearest(playerid);

    if(vehid == -1)
        return Error(playerid, "Invalid vehicle id!");
    // if(IsPlayerInRangeOfPoint(playerid, 4.0, 2194.9961,-2625.7346,13.5864) || IsPlayerInRangeOfPoint(playerid, 4.0, 2195.4260,-2615.7813,13.5864) || IsPlayerInRangeOfPoint(playerid, 4.0, 2194.8027,-2605.1270,13.5864))
    // {
    if(Vehicle_IsOwner(playerid, vehid))
    {
        format(string,sizeof(string),"Slot\tMod Type\tModel\n");
        /*if(pData[playerid][pVip] > 1)
        {*/
        for (new i = 0; i < MAX_VEHICLE_OBJECT; i++)
        {
            if(VehicleObjects[vehid][i][vehObjectExists])
            {
                if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_BODY)
                {
                    format(string,sizeof(string),"%s%d\t"GREEN_E"Mod\t%s\n", string, i, GetVehObjectNameByModel(VehicleObjects[vehid][i][vehObjectModel]));
                }
                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_TEXT)
                {
                    format(string,sizeof(string),"%s%d\t"GREEN_E"Sticker\t%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                }
                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_LIGHT)
                {
                    format(string,sizeof(string),"%s%d\t"GREEN_E"SpotLight\t%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                }
            }
            else
            {
                format(string, sizeof(string), "%sNew\tMod\n", string);
            }
            if (count < 10)
            {
                ListedVehObject[playerid][count] = i;
                count = count + 1;
            }
        }
        /*}
        else
        {
            for (new i = 0; i < 3; i ++)
            {
                if(VehicleObjects[vehid][i][vehObjectExists])
                {
                    if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_BODY)
                    {
                        format(string,sizeof(string),"%s%d\t"GREEN_E"Mod\t%s\n", string, i, GetVehObjectNameByModel(VehicleObjects[vehid][i][vehObjectModel]));
                    }
                    else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_TEXT)
                    {
                        format(string,sizeof(string),"%s%d\t"GREEN_E"Sticker\t%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                    }
                    else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_LIGHT)
                    {
                        format(string,sizeof(string),"%s%d\t"GREEN_E"SpotLight\t%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                    }
                }
                else
                {
                    format(string, sizeof(string), "%sNew\tMod\n", string);
                }
                if (count < 10)
                {
                    ListedVehObject[playerid][count] = i;
                    count = count + 1;
                }
            }
        }*/
    
        if(!count) 
        {
            Error(playerid, "You don't have vehicle toys installed!");
        }
        else 
        {
            Player_EditVehicleObject[playerid] = vehid;
            ShowPlayerDialog(playerid, EditingVehObject, DIALOG_STYLE_TABLIST_HEADERS, "Modshop: List", string, "Select","Exit");
        }
    }
    //}    
    else return Error(playerid, "You're not in a modshop.");
    return 1;
}
