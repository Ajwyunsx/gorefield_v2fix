package funkin.game;

import openfl.Lib;
import flixel.FlxG;
import hxvlc.util.Handle;

class Data
{
static var curMainMenuSelected:Int = 0;
static var curStoryMenuSelected:Int = 0;
static var moustacheMode:Bool = false;
static var catbotEnabled:Bool = false;

public static var weekProgress:Map<String, {song:String, weekMisees:Int, weekScore:Int, deaths:Int}> = [];

static var seenMenuCutscene:Bool = false;

public static function initSave()
    {
    Handle.init([]);

    // MECHANICS
    if (FlxG.save.data.baby == null) FlxG.save.data.baby = false;
    if (FlxG.save.data.ps_hard == null) FlxG.save.data.ps_hard = false;
    if (FlxG.save.data.scare_hard == null) FlxG.save.data.scare_hard = false;
    if (FlxG.save.data.blue_hard == null) FlxG.save.data.blue_hard = false;
    if (FlxG.save.data.orange_hard == null) FlxG.save.data.orange_hard = false;

    // VISUALS
    if (FlxG.save.data.bloom == null) FlxG.save.data.bloom = true;
    if (FlxG.save.data.glitch == null) FlxG.save.data.glitch = true;
    if (FlxG.save.data.warp == null) FlxG.save.data.warp = true;
    if (FlxG.save.data.static1 == null) FlxG.save.data.static1 = true;
    if (FlxG.save.data.wrath == null) FlxG.save.data.wrath = true;
    if (FlxG.save.data.heatwave == null) FlxG.save.data.heatwave = true;
    if (FlxG.save.data.drunk == null) FlxG.save.data.drunk = true;
    if (FlxG.save.data.vhs == null) FlxG.save.data.vhs = true;

    if (FlxG.save.data.drunk == null) FlxG.save.data.drunk = true;
    if (FlxG.save.data.saturation == null) FlxG.save.data.saturation = true;

    if (FlxG.save.data.trails == null) FlxG.save.data.trails = true;
    if (FlxG.save.data.particles == null) FlxG.save.data.particles = true;
    if (FlxG.save.data.flashing == null) FlxG.save.data.flashing = true;

    //PROGRESSION
    if (FlxG.save.data.weeksFinished == null) FlxG.save.data.weeksFinished = [false, false, false, false, false, false];
    if (FlxG.save.data.codesUnlocked == null) FlxG.save.data.codesUnlocked = false;
    if (FlxG.save.data.weeksUnlocked == null) FlxG.save.data.weeksUnlocked = [true, false, false, false, false, false, false, false];

    if (FlxG.save.data.beatWeekG1 == null) FlxG.save.data.beatWeekG1 = false;
    if (FlxG.save.data.beatWeekG2 == null) FlxG.save.data.beatWeekG2 = false;
    if (FlxG.save.data.beatWeekG3 == null) FlxG.save.data.beatWeekG3 = false;
    if (FlxG.save.data.beatWeekG4 == null) FlxG.save.data.beatWeekG4 = false;
    if (FlxG.save.data.beatWeekG5 == null) FlxG.save.data.beatWeekG5 = false;
    if (FlxG.save.data.beatWeekG6 == null) FlxG.save.data.beatWeekG6 = false;
    if (FlxG.save.data.beatWeekG7 == null) FlxG.save.data.beatWeekG7 = false;
    if (FlxG.save.data.beatWeekG8 == null) FlxG.save.data.beatWeekG8 = false;
    if (FlxG.save.data.firstTimeLanguage == null) FlxG.save.data.firstTimeLanguage = true;

    if(FlxG.save.data.weekProgress == null) FlxG.save.data.weekProgress = ["" => {}];
    weekProgress = FlxG.save.data.weekProgress;
    // CODES 
    if (FlxG.save.data.extrasSongs == null) FlxG.save.data.extrasSongs = [];
    if (FlxG.save.data.extrasSongsIcons == null) FlxG.save.data.extrasSongsIcons = [];
    if (FlxG.save.data.codesList == null) FlxG.save.data.codesList = ["HUMUNGOSAURIO", "PUEBLO MARRON"];

    // EASTER EGG
    if (FlxG.save.data.canVisitArlene == null) FlxG.save.data.canVisitArlene = false;
    if (FlxG.save.data.hasVisitedPhase == null) FlxG.save.data.hasVisitedPhase = false;
    if (FlxG.save.data.paintPosition == null) FlxG.save.data.paintPosition = -1;
    if (FlxG.save.data.arlenePhase == null) FlxG.save.data.arlenePhase = 0;
    
    // CREDITS
    if (FlxG.save.data.alreadySeenCredits == null) FlxG.save.data.alreadySeenCredits = false;

    // OTHER
    if (FlxG.save.data.spanish == null) FlxG.save.data.spanish = false;
    if (FlxG.save.data.dev == null) FlxG.save.data.dev = false;
}
}
