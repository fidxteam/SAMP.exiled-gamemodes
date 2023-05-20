//------------[ Textdraw ]------------


//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];
new Text:TextTime, Text:TextDate;

//Server Name textdraw
new Text:SOIRP_TXD;

new TD_Random_Messages_Intro[ ][ ] =
{
	"Exiled ~w~Roleplay",
	"~b~~w~Exiled.boards.net",
	"~w~Exiled ~r~Roleplay"
};

function TDUpdates()
{
	TextDrawSetString(Text:SOIRP_TXD, TD_Random_Messages_Intro[random(sizeof(TD_Random_Messages_Intro))]);
}

new Text:DPvehfare[MAX_PLAYERS];
new Text:TaxiTDX[MAX_PLAYERS];
new PlayerText:ActiveTD[MAX_PLAYERS];

new PlayerText:PlayerTD[MAX_PLAYERS][9];
new PlayerBar:ProgresBarFuel[MAX_PLAYERS];
new PlayerText:NewHBE[MAX_PLAYERS][6];
new PlayerText:BarLapar[MAX_PLAYERS];
new PlayerText:BarHaus[MAX_PLAYERS];
new PlayerText:BarKencing[MAX_PLAYERS];


CreatePlayerTextDraws(playerid)
{
	

	//New HBE
	NewHBE[playerid][0] = CreatePlayerTextDraw(playerid, 521.000000, 107.000000, "_");
	PlayerTextDrawFont(playerid, NewHBE[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, NewHBE[playerid][0], 0.600000, 1.449980);
	PlayerTextDrawTextSize(playerid, NewHBE[playerid][0], 290.000000, 16.000000);
	PlayerTextDrawSetOutline(playerid, NewHBE[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, NewHBE[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, NewHBE[playerid][0], 2);
	PlayerTextDrawColor(playerid, NewHBE[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, NewHBE[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, NewHBE[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, NewHBE[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, NewHBE[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, NewHBE[playerid][0], 0);

	BarLapar[playerid] = CreatePlayerTextDraw(playerid, 512.000000, 106.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BarLapar[playerid], 4);
	PlayerTextDrawLetterSize(playerid, BarLapar[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BarLapar[playerid], 18.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, BarLapar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BarLapar[playerid], 0);
	PlayerTextDrawAlignment(playerid, BarLapar[playerid], 1);
	PlayerTextDrawColor(playerid, BarLapar[playerid], 16711895);
	PlayerTextDrawBackgroundColor(playerid, BarLapar[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BarLapar[playerid], 50);
	PlayerTextDrawUseBox(playerid, BarLapar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BarLapar[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BarLapar[playerid], 0);

	NewHBE[playerid][1] = CreatePlayerTextDraw(playerid, 587.000000, 107.000000, "_");
	PlayerTextDrawFont(playerid, NewHBE[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, NewHBE[playerid][1], 0.600000, 1.449980);
	PlayerTextDrawTextSize(playerid, NewHBE[playerid][1], 290.000000, 16.500000);
	PlayerTextDrawSetOutline(playerid, NewHBE[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, NewHBE[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, NewHBE[playerid][1], 2);
	PlayerTextDrawColor(playerid, NewHBE[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, NewHBE[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, NewHBE[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, NewHBE[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, NewHBE[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, NewHBE[playerid][1], 0);

	NewHBE[playerid][2] = CreatePlayerTextDraw(playerid, 554.000000, 107.000000, "_");
	PlayerTextDrawFont(playerid, NewHBE[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, NewHBE[playerid][2], 0.600000, 1.449980);
	PlayerTextDrawTextSize(playerid, NewHBE[playerid][2], 290.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NewHBE[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, NewHBE[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, NewHBE[playerid][2], 2);
	PlayerTextDrawColor(playerid, NewHBE[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, NewHBE[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, NewHBE[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, NewHBE[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, NewHBE[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, NewHBE[playerid][2], 0);

	BarHaus[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 106.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BarHaus[playerid], 4);
	PlayerTextDrawLetterSize(playerid, BarHaus[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BarHaus[playerid], 18.500000, 15.000000);
	PlayerTextDrawSetOutline(playerid, BarHaus[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BarHaus[playerid], 0);
	PlayerTextDrawAlignment(playerid, BarHaus[playerid], 1);
	PlayerTextDrawColor(playerid, BarHaus[playerid], 16777150);
	PlayerTextDrawBackgroundColor(playerid, BarHaus[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BarHaus[playerid], 50);
	PlayerTextDrawUseBox(playerid, BarHaus[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BarHaus[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BarHaus[playerid], 0);

	BarKencing[playerid] = CreatePlayerTextDraw(playerid, 578.000000, 106.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BarKencing[playerid], 4);
	PlayerTextDrawLetterSize(playerid, BarKencing[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BarKencing[playerid], 18.000000, 15.000000);
	PlayerTextDrawSetOutline(playerid, BarKencing[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BarKencing[playerid], 0);
	PlayerTextDrawAlignment(playerid, BarKencing[playerid], 1);
	PlayerTextDrawColor(playerid, BarKencing[playerid], -1061109562);
	PlayerTextDrawBackgroundColor(playerid, BarKencing[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BarKencing[playerid], 50);
	PlayerTextDrawUseBox(playerid, BarKencing[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BarKencing[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BarKencing[playerid], 0);

	NewHBE[playerid][3] = CreatePlayerTextDraw(playerid, 513.000000, 100.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, NewHBE[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, NewHBE[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NewHBE[playerid][3], 15.500000, 24.500000);
	PlayerTextDrawSetOutline(playerid, NewHBE[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, NewHBE[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, NewHBE[playerid][3], 1);
	PlayerTextDrawColor(playerid, NewHBE[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, NewHBE[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, NewHBE[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, NewHBE[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, NewHBE[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, NewHBE[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, NewHBE[playerid][3], 2768);
	PlayerTextDrawSetPreviewRot(playerid, NewHBE[playerid][3], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, NewHBE[playerid][3], 1, 1);

	NewHBE[playerid][4] = CreatePlayerTextDraw(playerid, 545.000000, 104.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, NewHBE[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, NewHBE[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NewHBE[playerid][4], 15.000000, 20.000000);
	PlayerTextDrawSetOutline(playerid, NewHBE[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, NewHBE[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, NewHBE[playerid][4], 1);
	PlayerTextDrawColor(playerid, NewHBE[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, NewHBE[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, NewHBE[playerid][4], 0);
	PlayerTextDrawUseBox(playerid, NewHBE[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, NewHBE[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, NewHBE[playerid][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, NewHBE[playerid][4], 1546);
	PlayerTextDrawSetPreviewRot(playerid, NewHBE[playerid][4], -10.000000, 0.000000, -150.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, NewHBE[playerid][4], 1, 1);

	NewHBE[playerid][5] = CreatePlayerTextDraw(playerid, 575.000000, 102.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, NewHBE[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, NewHBE[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NewHBE[playerid][5], 18.500000, 20.500000);
	PlayerTextDrawSetOutline(playerid, NewHBE[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, NewHBE[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, NewHBE[playerid][5], 1);
	PlayerTextDrawColor(playerid, NewHBE[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, NewHBE[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, NewHBE[playerid][5], 0);
	PlayerTextDrawUseBox(playerid, NewHBE[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, NewHBE[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, NewHBE[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, NewHBE[playerid][5], 2525);
	PlayerTextDrawSetPreviewRot(playerid, NewHBE[playerid][5], 3.000000, -3.000000, 119.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, NewHBE[playerid][5], 1, 1);

	// Speedo Meter Baru
	PlayerTD[playerid][0] = CreatePlayerTextDraw(playerid, 586.000000, 383.000000, "_");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][0], 0.600000, 6.150002);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][0], 298.500000, 91.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][0], 0);

	PlayerTD[playerid][1] = CreatePlayerTextDraw(playerid, 586.000000, 383.000000, "_");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][1], 0.600000, 0.799996);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][1], 298.500000, 91.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][1], -1962934017);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][1], 0);

	PlayerTD[playerid][2] = CreatePlayerTextDraw(playerid, 586.000000, 380.000000, "INFERNUS");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][2], 0.220833, 1.250000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][2], -206);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][2], 0);

	PlayerTD[playerid][3] = CreatePlayerTextDraw(playerid, 543.000000, 396.000000, "SPEED:");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][3], 0.179167, 1.100000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][3], 0);

	PlayerTD[playerid][4] = CreatePlayerTextDraw(playerid, 543.000000, 410.000000, "HEALTH:");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][4], 0.179167, 1.100000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][4], 0);

	PlayerTD[playerid][5] = CreatePlayerTextDraw(playerid, 543.000000, 425.000000, "FUEL:");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][5], 0.179167, 1.100000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][5], 0);

	PlayerTD[playerid][6] = CreatePlayerTextDraw(playerid, 592.000000, 408.000000, "100%");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][6], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][6], 0.233333, 1.500000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][6], 9109759);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][6], 0);

	PlayerTD[playerid][7] = CreatePlayerTextDraw(playerid, 589.000000, 394.000000, "1000");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][7], 0.250000, 1.500000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][7], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][7], 9109759);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][7], 0);

	PlayerTD[playerid][8] = CreatePlayerTextDraw(playerid, 615.000000, 396.000000, "KMH");
	PlayerTextDrawFont(playerid, PlayerTD[playerid][8], 2);
	PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][8], 0.179166, 1.100000);
	PlayerTextDrawTextSize(playerid, PlayerTD[playerid][8], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, PlayerTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, PlayerTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, PlayerTD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][8], 0);

	//Info textdraw
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 361.385, "Selamat Datang!");
 	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);
	
	ActiveTD[playerid] = CreatePlayerTextDraw(playerid, 274.000000, 176.583435, "Mengisi Ulang...");
	PlayerTextDrawLetterSize(playerid, ActiveTD[playerid], 0.374000, 1.349166);
	PlayerTextDrawAlignment(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawColor(playerid, ActiveTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ActiveTD[playerid], 255);
	PlayerTextDrawFont(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);


	/*TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 565.500000, 405.833404, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][3], 68.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);

	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 565.500000, 420.416717, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 68.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);

	TDEditor_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 565.500000, 435.000091, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][5], 68.000000, 8.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][5], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);*/

	TaxiTDX[playerid] = TextDrawCreate(427.000000, 400.583374, "Fare:");
	TextDrawLetterSize(TaxiTDX[playerid], 0.360498, 1.022500);
	TextDrawAlignment(TaxiTDX[playerid], 1);
	TextDrawColor(TaxiTDX[playerid], -1);
	TextDrawSetShadow(TaxiTDX[playerid], 0);
	TextDrawSetOutline(TaxiTDX[playerid], 1);
	TextDrawBackgroundColor(TaxiTDX[playerid], 255);
	TextDrawFont(TaxiTDX[playerid], 1);
	TextDrawSetProportional(TaxiTDX[playerid], 1);
	TextDrawSetShadow(TaxiTDX[playerid], 0);

	DPvehfare[playerid] = TextDrawCreate(462.000000, 401.166687, "$500.000");
	TextDrawLetterSize(DPvehfare[playerid], 0.216000, 0.952498);
	TextDrawAlignment(DPvehfare[playerid], 1);
	TextDrawColor(DPvehfare[playerid], 16711935);
	TextDrawSetShadow(DPvehfare[playerid], 0);
	TextDrawSetOutline(DPvehfare[playerid], 1);
	TextDrawBackgroundColor(DPvehfare[playerid], 255);
	TextDrawFont(DPvehfare[playerid], 1);
	TextDrawSetProportional(DPvehfare[playerid], 1);
	TextDrawSetShadow(DPvehfare[playerid], 0);

	/*TDEditor_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 459.000000, 415.749938, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][10], 61.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][10], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][10], 0);

	TDEditor_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 459.500000, 432.083221, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][11], 61.000000, 9.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][11], 16711935);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][11], 0);*/
}

CreateTextDraw()
{
	//Date and Time
	TextDate = TextDrawCreate(618.000000, 120.000000,"--");
	TextDrawBackgroundColor(TextDate, 255);
	TextDrawFont(TextDate, 1);
	TextDrawTextSize(TextDate, 735.500000, 610.000000);
	TextDrawLetterSize(TextDate, 0.199999, 1.250000);
	TextDrawSetOutline(TextDate, 1);
	TextDrawSetProportional(TextDate, 1);
	TextDrawAlignment(TextDate, 3);
	TextDrawSetShadow(TextDate, 1);
	TextDrawColor(TextDate,0xFFFFFFFF);

	TextTime = TextDrawCreate(600.000000, 150.000000,"--");
	TextDrawLetterSize(TextTime,0.270833, 1.150000);
	TextDrawFont(TextTime , 3);
	TextDrawTextSize(TextTime, 796.500000, 847.000000);
	TextDrawSetOutline(TextTime , 1);
	TextDrawAlignment(TextTime, 3);
    TextDrawSetProportional(TextTime , 1);
	TextDrawBackgroundColor(TextTime, 255);
	TextDrawSetShadow(TextTime, 1);
	TextDrawColor(TextTime,0xFFFFFFFF);
	
	//Server Name
	SOIRP_TXD = TextDrawCreate(25.777742, 421.119964, "~r~Exiled ~w~Roleplay");
	TextDrawLetterSize(SOIRP_TXD, 0.269998, 1.405864);
	TextDrawAlignment(SOIRP_TXD, 1);
	TextDrawColor(SOIRP_TXD, 0xFF0000FF);
	TextDrawSetShadow(SOIRP_TXD, 0);
	TextDrawSetOutline(SOIRP_TXD, 1);
	TextDrawBackgroundColor(SOIRP_TXD, 0x000000FF);
	TextDrawFont(SOIRP_TXD, 1);
	TextDrawSetProportional(SOIRP_TXD, 1);
	
	
}
