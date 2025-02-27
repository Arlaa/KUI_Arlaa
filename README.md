# Kui_Arlaa
Collection of my custom mods for the [KuiNameplates](https://www.curseforge.com/wow/addons/kuinameplates) World of Warcraft addon. Some are sourced from [here](https://github.com/kesava-wow/kuinameplates-customs) while others are my own with the help of AI and friends. 

## Mods
| Mod  | What It Does |
| :------------ |:--------------|
| kui.background-colour      | Changes the background colour of the castbar and healthbar to black.    |
| kui.omnicc-auras.lua      | Enables omnicc compatibility with the cooldown text and swipe.    |
| kui.purge-position.lua      | Repositions the purge auras to the right side of the nameplate.    |
| kui.target-border.lua     | Adds a white border around the nameplate if it is your current target.    |
| kui.text-position.lua      | Repositions the unit and spell text to the left side. Ignores health text.  Shoud use with Name Only mode. |
| kui.friendlynameplate-nonstack      | Disables stacking for friendly nameplates. Enemy nameplates still stack accordingly.   |

## How do I install/use it?
1. Navigate to the latest release page on the right hand side or Curseforge.
2. Download the zipped file. It may look like so: `v1.0.0-release.zip`
3. Drag the Kui_Arlaa folder into your addons folder which can be found at `World of Warcraft\_retail_\Interface\AddOns`
4. Restart or reload your World of Warcraft client and enable it in the addons menu

## Example in action
![Arlaa UI](https://i.ibb.co/RYZt8tr/Wo-WScrn-Shot-011825-201502.jpg)

## Use the profile above
If you want to try it out with my personal profile, import it by using the following command:
**/knp import**

```
Arlaa{auras_centre=false,auras_icon_normal_size=35,auras_icon_squareness=0.8,auras_offset=2,auras_purge_size=38,bar_animation=2,bar_texture=Atrocity,bot_vertical_offset=6,castbar_colour={1=0.965,2=0.714,3=0},castbar_detach_combine=false,castbar_detach_nameonly=true,castbar_detach_offset=-1,castbar_detach_width=230,castbar_height=22,castbar_icon=false,castbar_name_vertical_offset=2.5,castbar_shield=false,castbar_showfriend=false,castbar_unin_colour={1=0.557,2=0.557,3=0.557},classpowers_enable=false,clickthrough_friend=true,colour_friendly={1=0.2,2=0.6,3=0.1,4=1},colour_hated={1=0.7,2=0.2,3=0.1,4=1},colour_player={1=0.2,2=0.5,3=0.9,4=1},colour_player_class=true,colour_tapped={1=0.839,2=0.839,3=0.839,4=1},cvar_disable_alpha=false,cvar_enable=true,cvar_name_only=true,cvar_show_friendly_npcs=true,execute_enabled=false,fade_non_target_alpha=1,font_face=PT Sans Narrow Bold,font_size_normal=14,font_size_small=14,frame_glow_threat=false,frame_height=28,frame_target_size=false,frame_width=230,glow_as_shadow=false,health_text=true,health_text_hostile_dmg=6,health_text_hostile_max=6,hide_names=false,name_vertical_offset=6,nameonly_health_colour=false,target_arrows_size=40,target_glow=false,target_glow_colour={1=0.302,2=0.702,3=1,4=1}}
```
