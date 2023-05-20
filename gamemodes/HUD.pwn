stock UpdateHUD(playerid)
{
    if( pData[playerid][pHBEMode] == 1)
    {
        new Float: hungry, 
            Float: energy,
            Float: piss;

        hungry = pData[playerid][pHunger] * 18.0 / 100;
        PlayerTextDrawTextSize(playerid, BarLapar[playerid], hungry, 15.0);
        PlayerTextDrawShow(playerid, BarLapar[playerid]);

        energy = pData[playerid][pEnergy] * 18.0 / 100;
        PlayerTextDrawTextSize(playerid, BarHaus[playerid], energy, 15.0);
        PlayerTextDrawShow(playerid, BarHaus[playerid]);

        piss = pData[playerid][pBladder] * 18.0 / 100;
        PlayerTextDrawTextSize(playerid, BarKencing[playerid], piss, 15.0);
        PlayerTextDrawShow(playerid, BarKencing[playerid]);

    }
}

stock ShowHUD(playerid)
{
	if(pData[playerid][pHBEMode] == 1)
	{
        for(new i; i < 6; i++)
		    PlayerTextDrawShow(playerid, NewHBE[playerid][i]);
        
        TextDrawShowForPlayer(playerid, SOIRP_TXD);
        TextDrawShowForPlayer(playerid, TextDate);
        TextDrawShowForPlayer(playerid, TextTime);

        PlayerTextDrawShow(playerid, BarLapar[playerid]);
        PlayerTextDrawShow(playerid, BarHaus[playerid]);
        PlayerTextDrawShow(playerid, BarKencing[playerid]);

		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
		{
			for(new txd; txd < 9; txd++)
		        PlayerTextDrawShow(playerid, PlayerTD[playerid][txd]);

	        ShowPlayerProgressBar(playerid, ProgresBarFuel[playerid]);
		}
	}
	return 1;
}

stock HideHUD(playerid)
{
    for(new i; i < 6; i++)
        PlayerTextDrawHide(playerid, NewHBE[playerid][i]);
        
    TextDrawHideForPlayer(playerid, SOIRP_TXD);
    TextDrawHideForPlayer(playerid, TextDate);
    TextDrawHideForPlayer(playerid, TextTime);

    PlayerTextDrawHide(playerid, BarLapar[playerid]);
    PlayerTextDrawHide(playerid, BarHaus[playerid]);
    PlayerTextDrawHide(playerid, BarKencing[playerid]);

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
	{
		for(new i; i < 10; i++)
			PlayerTextDrawHide(playerid, PlayerTD[playerid][i]);

		HidePlayerProgressBar(playerid, ProgresBarFuel[playerid]);
	}
	return 1;
}


ptask TimerHUD[1000](playerid)
{
    if(pData[playerid][pSpawned])
        UpdateHUD(playerid);
}