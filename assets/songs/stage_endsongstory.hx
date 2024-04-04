import StringTools;

var actualWeekSongs:Map<String, Array<String>> = [];

function create(){
    actualWeekSongs.set('Principal Week...',["The Great Punishment", "Curious Cat", "Metamorphosis", "Hi Jon", "Terror in the Heights", "BIGotes"]);
    actualWeekSongs.set('Lasagna Boy Week...',["Fast Delivery", "Health Inspection"]);
    actualWeekSongs.set('Sansfield Week...',["Cat Patella", "Mondaylovania", "ULTRA FIELD"]);
    actualWeekSongs.set('ULTRA Week...',["The Complement", "R0ses and Quartzs"]);
    actualWeekSongs.set('Cryfield Week...',["Cryfield", "Nocturnal Meow"]);
}


function setWeekProgress(song:String){ //PlayState.instance.SONG.meta.name
	weekProgress.set(PlayState.storyWeek.name, {song: song.toLowerCase(), weekMisees: PlayState.campaignMisses, weekScore: PlayState.campaignScore, deaths: PlayState.deathCounter});
    trace("Set Progress For " + PlayState.storyWeek.name + ", " + song);
}

function postCreate(){
    if(!PlayState.isStoryMode) return;

    switch(PlayState.storyWeek.name){case 'Code Songs...' | 'Cartoon World...' | 'Binky Circus...' | "Godfield's Will...": return;}

    if (PlayState.isStoryMode && PlayState.storyWeek.songs[0].name.toLowerCase() != PlayState.instance.SONG.meta.name.toLowerCase()) // Makes sure it isnt the first song
        setWeekProgress(PlayState.instance.SONG.meta.name);

    if (weekProgress.exists(PlayState.storyWeek.name) && actualWeekSongs.get(PlayState.storyWeek.name)[0].toLowerCase() == PlayState.instance.SONG.meta.name.toLowerCase()){ // Clear week progress if start over
        weekProgress.remove(PlayState.storyWeek.name);
        trace("Reset Progress For " + PlayState.storyWeek.name);
    }

    if(weekProgress.exists(PlayState.storyWeek.name))
        trace("Loaded Week:" +  PlayState.storyWeek.name + " Progress");

    trace(PlayState.storyPlaylist);
}

function onSongEnd(){
    if(PlayState.isStoryMode){
        switch(PlayState.instance.SONG.meta.name.toLowerCase()){
            case 'bigotes':
                if(FlxG.save.data.beatWeekG1) return;

                FlxG.save.data.beatWeekG1 = true;
                FlxG.save.data.weeksFinished = [true, false, false, false, false, false];
                FlxG.save.data.weeksUnlocked = [true, true, false, false, false, false, false, false];
                trace("BEAT WEEK 1");
            case 'health inspection':
                if(FlxG.save.data.beatWeekG2) return;

                FlxG.save.data.beatWeekG2 = true;
                FlxG.save.data.weeksFinished = [true, true, false, false, false, false];
                FlxG.save.data.weeksUnlocked = [true, true, true, false, false, false, false, false];
                trace("BEAT WEEK 2");           
            case 'ultra field':
                if(FlxG.save.data.beatWeekG3) return;

                FlxG.save.data.beatWeekG3 = true;
                FlxG.save.data.weeksFinished = [true, true, true, false, false, false];
                FlxG.save.data.weeksUnlocked = [true, true, true, true, false, false, false, false];
                trace("BEAT WEEK 3");  
            case 'r0ses and quartzs':
                if(FlxG.save.data.beatWeekG4) return;

                FlxG.save.data.beatWeekG4 = true;
                FlxG.save.data.weeksFinished = [true, true, true, true, false, false];
                FlxG.save.data.weeksUnlocked = [true, true, true, true, true, false, false, false];
                trace("BEAT WEEK 4");       
            case 'nocturnal meow':
                if(FlxG.save.data.beatWeekG5) return;

                FlxG.save.data.beatWeekG5 = true;
                FlxG.save.data.weeksFinished = [true, true, true, true, true, false];
                FlxG.save.data.weeksUnlocked = [true, true, true, true, true, true, false, false];
                trace("BEAT WEEK 5");   
            case 'cataclysm':
                if(FlxG.save.data.beatWeekG6) return;

                FlxG.save.data.beatWeekG6 = true;
                FlxG.save.data.beatWeekG8 = true;
                FlxG.save.data.weeksFinished = [true, true, true, true, true, true];
                FlxG.save.data.weeksUnlocked = [true, true, true, true, true, true, false, true];
                FlxG.save.data.codesUnlocked = true;
                trace("BEAT WEEK 6");   
        }
        FlxG.save.flush();
    }
}

function destroy(){
    if(!PlayState.isStoryMode) return;

    if (PlayState.storyPlaylist.length <= 0){
        weekProgress.remove(PlayState.storyWeek.name);
        trace("Cleared Progress For " + PlayState.storyWeek.name);
    }
    
    FlxG.save.data.weekProgress = weekProgress;
    FlxG.save.flush();
    trace("Saved Progress For " + PlayState.storyWeek.name);
    //trace(FlxG.save.data.weekProgress);
    //trace(PlayState.storyPlaylist);
}