#include <YSI\y_hooks>

new DCC_Role: RoleWarga, 
    DCC_Guild: GuildID, 
    DCC_Channel: Register,
	DCC_Channel: Unverify,
	DCC_Channel: ServerLog;

hook OnGameModeInit()
{
    RoleWarga   = DCC_FindRoleById("1092844914603200553");
    GuildID     = DCC_FindGuildById("1092844914565451808");
    Register    = DCC_FindChannelById("1092992623146442822");
    Unverify    = DCC_FindChannelById("1092844916620660811");
    ServerLog    = DCC_FindChannelById("1096399137219543080");
}

IsValidNameUCP(const name[])
{
	new len = strlen(name);

	for(new ch = 0; ch != len; ch++)
	{
		switch(name[ch])
		{
			case 'A' .. 'Z', 'a' .. 'z', '0' .. '9': continue;
			default: return false;
		}
	}
	return true;
}

function DCC_DM(str[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();
	DCC_SendChannelMessage(PM, str);
	return 1;
}

function DCC_DM_EMBED(str[], pin, id[])
{
    new DCC_Channel:PM, query[200];
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="EXILED ROLEPLAY", .image_url="https://cdn.discordapp.com/avatars/1093068025315479594/ff8d08efd96903a5e28c2d63f50a2295.png?size=4096");
	new str1[100], str2[100];

	format(str1, sizeof str1, "```\nHalo!\nUCP kamu berhasil terverifikasi,\nGunakan PIN dibawah ini untuk login ke Game```");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP");
	format(str2, sizeof str2, "\n```%s```", str);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "PIN");
	format(str2, sizeof str2, "\n```%d```", pin);
	DCC_AddEmbedField(embed, str1, str2, bool:1);

	DCC_SendChannelEmbedMessage(PM, embed);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `ucp` (`username`, `pin`, `discordid`, `registerdate`) VALUES ('%e', '%d', '%e', '%d')", str, pin, id, gettime());
	mysql_tquery(g_SQL, query);
	return 1;
}

function CheckDiscordUCP(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows();
	new DCC_User: user, dc[100];
	new verifycode = RandomEx(111111, 988888);
	if(rows > 0)
	{
		return DCC_SendChannelMessage(Register, "**[INFO]:** Nama UCP account tersebut sudah terdaftar");
	}
	else 
	{
		user = DCC_FindUserById(DiscordID);
		DCC_SetGuildMemberNickname(GuildID, user, Nama_UCP);
		DCC_AddGuildMemberRole(GuildID, user, RoleWarga);

		format(dc, sizeof(dc),  "**[UCP]:** __%s__ is now Verified .", Nama_UCP);
		DCC_SendChannelMessage(Register, dc);
		DCC_CreatePrivateChannel(user, "DCC_DM_EMBED", "sds", Nama_UCP, verifycode, DiscordID);
	}
	return 1;
}

function CheckDiscordID(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows(), ucp[20], dc[100];
	if(rows > 0)
	{
		cache_get_value_name(0, "username", ucp);

		format(dc, sizeof(dc),  "**[INFO]:** Kamu sudah mendaftar UCP sebelumnya dengan nama **%s**", ucp);
		return DCC_SendChannelMessage(Register, dc);
	}
	else 
	{
		new characterQuery[178];
		mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `ucp` WHERE `username` = '%s'", Nama_UCP);
		mysql_tquery(g_SQL, characterQuery, "CheckDiscordUCP", "ss", DiscordID, Nama_UCP);
	}
	return 1;
}

DCMD:register(user, channel, params[])
{
	new id[21];
    if(channel != Register)
		return 1;
    if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**[USAGE]:** __!register__ [UCP NAME]");
	if(!IsValidNameUCP(params))
		return DCC_SendChannelMessage(channel, "**Gunakan nama UCP bukan nama IC!**");
	
	DCC_GetUserId(user, id, sizeof id);

	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `ucp` WHERE `discordid` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckDiscordID", "ss", id, params);
	return 1;
}

function CheckReverify(DiscordID[])
{
	new rows = cache_num_rows(), Nama_UCP[20], dc[100], PIN;
	new DCC_User: user;
	if(rows > 0)
	{
		// ketika player ada di database !
		cache_get_value_name(0, "username", Nama_UCP);
		cache_get_value_name_int(0, "pin", PIN);

		user = DCC_FindUserById(DiscordID);
		DCC_SetGuildMemberNickname(GuildID, user, Nama_UCP);
		DCC_AddGuildMemberRole(GuildID, user, RoleWarga);

		format(dc, sizeof(dc),  "**[UCP]:** __%s__ berhasil reverify akun.", Nama_UCP);
		DCC_SendChannelMessage(Register, dc);
		DCC_CreatePrivateChannel(user, "Embed_Reverify", "sds", Nama_UCP, PIN, DiscordID);
	}
	else 
	{
		// ketika player tidak ada di database!
		format(dc, sizeof(dc),  "**[UCP]:** __%s__ anda belum register akun UCP!.", Nama_UCP);
		DCC_SendChannelMessage(Register, dc);
	}
	return 1;
}

function Embed_Reverify(str[], pin, id[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="EXILED ROLEPLAY", .image_url="https://cdn.discordapp.com/avatars/1093068025315479594/ff8d08efd96903a5e28c2d63f50a2295.png?size=4096");
	new str1[100], str2[100];

	format(str1, sizeof str1, "```\nHalo!\nUCP kamu berhasil reverif,\nGunakan PIN dibawah ini untuk login ke Game```");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP");
	format(str2, sizeof str2, "\n```%s```", str);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "PIN");
	format(str2, sizeof str2, "\n```%d```", pin);
	DCC_AddEmbedField(embed, str1, str2, bool:1);

	DCC_SendChannelEmbedMessage(PM, embed);
	return 1;
}

DCMD:reverify(user, channel, params[])
{
	new id[21];
    if(channel != Register)
		return 1;
	
	DCC_GetUserId(user, id, sizeof id);

	// Pengecekan id discord apakah ada di dalam database
	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `ucp` WHERE `discordid` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckReverify", "s", id);
	return 1;
}

function UnverifyUCP(UsernameUCP[])
{
	new rows = cache_num_rows(), dc[128];
	if(rows > 0)
	{
		new query[256];
		// ketika player ada di database !
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM ucp WHERE username = '%s'", UsernameUCP);
		mysql_tquery(g_SQL, query);

		format(dc, sizeof(dc),  "**[UCP]:** __%s__ berhasil dihapus dari database!.", UsernameUCP);
		DCC_SendChannelMessage(Unverify, dc);
	}
	else 
	{
		// ketika player tidak ada di database!
		format(dc, sizeof(dc),  "**[UCP]:** __%s__ tidak ada!.", UsernameUCP);
		DCC_SendChannelMessage(Unverify, dc);
	}
	return 1;
}

DCMD:unverify(user, channel, params[])
{
	if(channel != Unverify)
		return 1;
	if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**[USAGE]:** __!unverify__ [UCP NAME]");

	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `ucp` WHERE `username` = '%s'", params);
	mysql_tquery(g_SQL, characterQuery, "UnverifyUCP", "s", params);
	return 1;
}

