
ShowCharacterMenu(playerid) 
{
    new name[MAX_CHARACTERS * 50], count;

    for (new i; i < MAX_CHARACTERS; i ++) if(CharacterList[playerid][i][0] != EOS) {
      new cagus[128];
      format(cagus, sizeof cagus, "%s\n", CharacterList[playerid][i]);
      strcat(name, cagus);
      count++;
    }

    if(count < MAX_CHARACTERS)
      strcat(name, "<New Character>");

    ShowPlayerDialog(playerid, DIALOG_SELECTCHAR, DIALOG_STYLE_LIST, "Character List", name, "Select", "Quit");
    return 1;
}

function OnCharacterLoaded(playerid) 
{
    for (new i = 0; i < MAX_CHARACTERS; i ++) {
      CharacterList[playerid][i][0] = EOS;
    }

    for (new i = 0; i < cache_num_rows(); i ++) {
      cache_get_value_name(i, "username", CharacterList[playerid][i], 128);
    }

    ShowCharacterMenu(playerid);
    return 1;
}