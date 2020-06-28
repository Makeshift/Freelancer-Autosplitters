/**************************
Version: 1.2
GitHub: https://github.com/Makeshift/Freelancer-Autosplitters
Author: Makeshift
***************************/

state("Freelancer")
{
    int nn_objective_id : 0x272310;
    int in_game : 0x278BA0;
    int player_lost_control: 0x26CF00;
}

startup {
// run when the script first loads, add settings here
    print("Autosplitter started");
    refreshRate = 30;
    
    vars.onStart = (Action)( () => {
        vars.autoSplitIndex = 0;
        vars.gameHasStarted = false;
        vars.timerModel = new TimerModel { CurrentState = timer };
        vars.player_level = -1;
        vars.prev_player_level = -1;
        vars.next_level_skip = null;
        vars.skip_at_level = null;
    });
    vars.onStart();
    timer.OnStart += (System.EventHandler)( (s, e) => {
        vars.onStart();
    });
    timer.OnReset += (LiveSplit.Model.Input.EventHandlerT<LiveSplit.Model.TimerPhase>)( (s, e) => {
        vars.onStart();
    });

    vars.autoSplits = new Tuple<string, string, string, int[], int>[]{
    // Format: Objective name in files, Mission, Objective Friendly Name, ID in files (+ list of IDs that will trigger this), enabled by default, force level skip (will skip to this split if a levelup occurs, -1 for ignored)
    // Note: 21660 is a special "no objective" objective and should be used sparingly
        //Intro
        Tuple.Create("mlog_equip"                                        , "Intro"       , "Meet Juni"                            , new int[] {21820}                       , -1) ,
        //Mission 1a

        Tuple.Create("mlog_54747"                                        , "Mission 1a"  , "-Launch"                              , new int[] {21825}                       , -1) ,
        Tuple.Create("mlog_21830"                                        , "Mission 1a"  , "-Fight"                               , new int[] {21830}                       , -1) ,
        Tuple.Create("mlog_dockTL"                                       , "Mission 1a"  , "-Dock Trade Lane"                     , new int[] {21875, 21660, 21835, 21840}                       , -1) ,
        Tuple.Create("mlog_meettransports"                               , "Mission 1a"  , "-Escort Transports"                   , new int[] {21845}                       , -1) ,
        Tuple.Create("mlog_21860"                                        , "Mission 1a"  , "-Kill Rogues"                         , new int[] {21860}                       , -1) ,
        Tuple.Create("mlog_21890"                                        , "Mission 1a"  , "-Head to Pittsburgh"                  , new int[] {21890}                       , -1) ,
        Tuple.Create("mlog_21870"                                        , "Mission 1a"  , "{Mission 1A} Land"                    , new int[] {21870}                       , 1) ,
        //Mission 1b
        Tuple.Create("mlog_launch"                                       , "Mission 1b"  , "-Launch"                              , new int[] {22065}                       , -1) ,
        Tuple.Create("mlog_51023"                                        , "Mission 1b"  , "-Defend Prison Ship"                  , new int[] {22020}                       , -1) ,
        Tuple.Create("nn_searchpt1"                                      , "Mission 1b"  , "-Go to waypoint"                      , new int[] {22025}                       , -1) ,
        Tuple.Create("mlog_51031"                                        , "Mission 1b"  , "-Defend Beta 4"                       , new int[] {22045}                       , -1) ,
        Tuple.Create("nn_beta4pt"                                        , "Mission 1b"  , "-Into the field"                      , new int[] {22040}                       , -1) ,
        Tuple.Create("nn_uratbase"                                       , "Mission 1b"  , "-Destroy the base"                    , new int[] {22085, 22090, 22050}                       , -1) ,
        Tuple.Create("mlog_51027"                                        , "Mission 1b"  , "{Mission 1B} Back to Pittsburgh"      , new int[] {22055, 21660, 22095}                       , -1) ,
        //Mission 1 Free Time
        Tuple.Create("free_time1"                                        , "Free Time 1" , "Mission 1 Free Time"                  , new int[] {979}                         , 2) ,
        //Mission 2
        Tuple.Create("meet_juni"                                         , "Mission 2"   , "-Manhattan Bar"                       , new int[] {22210}                       , 3) ,
        Tuple.Create("talk_to_juni"                                      , "Mission 2"   , "-Talk to Juni"                        , new int[] {22285}                       , -1) ,
        Tuple.Create("first_launch"                                      , "Mission 2"   , "-Undock"                              , new int[] {22220}                       , -1) ,
        Tuple.Create("take_tl1"                                          , "Mission 2"   , "-Trade Lanes"                         , new int[] {22225}                       , -1) ,
        Tuple.Create("jump"                                              , "Mission 2"   , "-Jump"                                , new int[] {22230}                       , -1) ,
        Tuple.Create("follow_again"                                      , "Mission 2"   , "-Go to Waypoint"                      , new int[] {22235}                       , -1) ,
        Tuple.Create("start_scanning"                                    , "Mission 2"   , "-Start Scanning"                      , new int[] {22240}                       , -1) ,
        Tuple.Create("engage_cosmo"                                      , "Mission 2"   , "-Engage Cosmo"                        , new int[] {22245}                       , -1) ,
        Tuple.Create("search"                                            , "Mission 2"   , "-Trade Lane"                          , new int[] {22255}                       , -1) ,
        Tuple.Create("defend_station"                                    , "Mission 2"   , "-Defend Station"                      , new int[] {22256}                       , -1) ,
        Tuple.Create("hunt"                                              , "Mission 2"   , "-Chase Ashcroft"                      , new int[] {22260}                       , -1) ,
        Tuple.Create("destroy_rogues"                                    , "Mission 2"   , "-Destroy Rogues"                      , new int[] {22269}                       , -1) ,
        Tuple.Create("destroy_ashcroft"                                  , "Mission 2"   , "-Kill Ashcroft"                       , new int[] {22262, 22263}                       , -1) ,
        Tuple.Create("no_id"                                             , "Mission 2"   , "-Go to Gate"                          , new int[] {22267}                       , -1) ,
        Tuple.Create("dock_li03_to_li01"                                 , "Mission 2"   , "-Jump"                                , new int[] {22268}                       , -1) ,
        Tuple.Create("no_id2"                                            , "Mission 2"   , "-TL & Fight & TL"                     , new int[] {22225}                       , -1) ,
        Tuple.Create("return"                                            , "Mission 2"   , "{Mission 2} Dock with Missouri"       , new int[] {22270}                       , -1) ,
        //Mission 2 Free Time
        Tuple.Create("free_time2"                                        , "Free Time 2" , "Mission 2 Free Time"                  , new int[] {21660}                       , 4) ,
        //Mission 3
        Tuple.Create("no_id"                                             , "Mission 3"   , "-Go to Bar on Manhattan"                     , new int[] {22505}                       , 5) ,
        Tuple.Create("no_id2"                                            , "Mission 3"   , "-Go to California Minor"              , new int[] {22410}                       , -1) ,
        Tuple.Create("mlog_land_on_ca_minor"                             , "Mission 3"   , "-Land on CA Minor"                    , new int[] {22415}                       , -1) ,
        Tuple.Create("mlog_meet_juni_in_the_bar"                         , "Mission 3"   , "-Meet Juni in the Bar"                , new int[] {22420}                       , -1) ,
        Tuple.Create("mlog_meet_juni_in_space_above_ca_minor"            , "Mission 3"   , "-Meet Juni in Space"                  , new int[] {22425}                       , -1) ,
        Tuple.Create("mlog_take_the_tradelane_to_san_diego"              , "Mission 3"   , "-Magellen Tradelane"                  , new int[] {22430}                       , -1) ,
        Tuple.Create("mlog_meet_up_with_convoy"                          , "Mission 3"   , "-Go to transports"                    , new int[] {22435}                       , -1) ,
        Tuple.Create("mlog_head_to_the_entrance_of_tha_barrera_passage"  , "Mission 3"   , "-Entrace of Barrera Passage"          , new int[] {22500}                       , -1) ,
        Tuple.Create("mlog_proceed_to_the_first_buoy"                    , "Mission 3"   , "-First Buoy"                          , new int[] {22445}                       , -1) ,
        Tuple.Create("mlog_proceed_to_the_second_buoy"                   , "Mission 3"   , "-Second Buoy"                         , new int[] {22450}                       , -1) ,
        Tuple.Create("mlog_proceed_to_the_third_buoy"                    , "Mission 3"   , "-Third Buoy"                          , new int[] {22460}                       , -1) ,
        Tuple.Create("mlog_defend_the_convoy"                            , "Mission 3"   , "-Defend the Convoy"                   , new int[] {22455}                       , -1) ,
        Tuple.Create("mlog_proceed_to_the_fourth_buoy"                   , "Mission 3"   , "-Fourth Buoy"                         , new int[] {22510}                       , -1) ,
        Tuple.Create("mlog_proceed_to_willard_station"                   , "Mission 3"   , "-Go to Willard Station"               , new int[] {22465}                       , -1) ,
        Tuple.Create("mlog_land_on_willard"                              , "Mission 3"   , "-Land on Willard Station"             , new int[] {22470}                       , -1) ,
        Tuple.Create("mlog_launch_and_meet_juni_outside_willard_station" , "Mission 3"   , "-Launch"                              , new int[] {22515}                       , -1) ,
        Tuple.Create("mlog_return_to_ca_minor"                           , "Mission 3"   , "-Return to California"                , new int[] {22475}                       , -1) ,
        Tuple.Create("mlog_destroy_the_rheinland_valkyries"              , "Mission 3"   , "-Destroy the Valkyries"               , new int[] {22520}                       , -1) ,
        Tuple.Create("mlog_return_to_ca_minor_after_valkyries"           , "Mission 3"   , "-Return to CA Minor"                  , new int[] {22525}                       , -1) ,
        Tuple.Create("mlog_land_on_ca_minor2"                            , "Mission 3"   , "-Land on CA Minor"                    , new int[] {22415}                       , -1) ,
        Tuple.Create("no_id3"                                            , "Mission 3"   , "-Head to the bar"                     , new int[] {22480}                       , -1) ,
        Tuple.Create("mlog_meet_juni_and_walker_in_space_above_ca_minor" , "Mission 3"   , "-Launch"                              , new int[] {22480}                       , -1) ,
        Tuple.Create("mlog_join_up_with_walker"                          , "Mission 3"   , "-Fly to Walker"                       , new int[] {22485}                       , -1) ,
        Tuple.Create("mlog_respond_to_distress_call"                     , "Mission 3"   , "-Fly to Willard"                      , new int[] {22490}                       , -1) ,
        Tuple.Create("mlog_protect_willard_station"                      , "Mission 3"   , "{Mission 3} Protect Willard"          , new int[] {22495}                       , -1) ,
        //Mission 3 Free Time
        Tuple.Create("free_time3"                                        , "Free Time 3" , "Mission 3 Free Time"                  , new int[] {1231}                        , 6) ,
        //Mission 4
        Tuple.Create("no_id"                                             , "Mission 4"   , "-Talk to Juni"                        , new int[] {979}                         , 7) ,
        Tuple.Create("nn_launch"                                         , "Mission 4"   , "-Launch"                              , new int[] {22608}                       , -1) ,
        Tuple.Create("nn_tl_to_ft_bush"                                  , "Mission 4"   , "-Go to Trade Lane"                    , new int[] {22610}                       , -1) ,
        Tuple.Create("nn_defend_yourselves"                              , "Mission 4"   , "-Don't Die"                           , new int[] {22612}                       , -1) ,
        Tuple.Create("land_on_base"                                      , "Mission 4"   , "-Dock at Benford"             , new int[] {22630, 22635, 22645, 22640}                       , -1) ,
        Tuple.Create("m4_no_id"                                      , "Mission 4"   , "-'Defend' Benford"             , new int[] {21660}                       , -1) ,
        Tuple.Create("nn_badlands_jumpgate"                              , "Mission 4"   , "-Go to Magellan Gate"                 , new int[] {22655}                       , -1) ,
        Tuple.Create("nn_leave_liberty"                                  , "Mission 4"   , "-Jump"                                , new int[] {22660}                       , -1) ,
        Tuple.Create("nn_f4_base"                                        , "Mission 4"   , "-Go toward F4"                        , new int[] {22665}                       , -1) ,
        Tuple.Create("nn_defend_yourself"                                , "Mission 4"   , "-Kill Bounty Hunters"                 , new int[] {22670}                       , -1) ,
        Tuple.Create("nn_hacker_base"                                    , "Mission 4"   , "-Fly to Mactan"                       , new int[] {22675}                       , -1) ,
        Tuple.Create("nn_dock_with_hacker_base"                          , "Mission 4"   , "-Dock with Mactan"                    , new int[] {22680}                       , -1) ,
        Tuple.Create("nn_leave_hacker_base"                              , "Mission 4"   , "-Undock"                              , new int[] {22682}                       , -1) ,
        Tuple.Create("nn_defend_hacker_base"                             , "Mission 4"   , "-Kill Rheinlanders"                   , new int[] {22685}                       , -1) ,
        Tuple.Create("nn_leeds_hole"                                     , "Mission 4"   , "-Go to Leeds Hole"                    , new int[] {22690}                       , -1) ,
        Tuple.Create("nn_jump_to_leeds"                                  , "Mission 4"   , "-Jump"                                , new int[] {22695}                       , -1) ,
        Tuple.Create("nn_leeds3"                                         , "Mission 4"   , "-Fly to Planet Leeds"                 , new int[] {22700}                       , -1) ,
        Tuple.Create("nn_leeds4"                                         , "Mission 4"   , "-Dock at Leeds"                       , new int[] {22702}                       , -1) ,
        Tuple.Create("nn_meet_tobias"                                    , "Mission 4"   , "{Mission 4} Meet with Tobias"         , new int[] {22705}                       , -1) ,
        //Mission 4 Free Time
        Tuple.Create("free_time4"                                        , "Free Time 4" , "Mission 4 Free Time"                  , new int[] {1231}                        , 8) ,
        //Mission 5
        Tuple.Create("nn_mission_start"                                  , "Mission 5"   , "-Dock on Planet Cambridge"            , new int[] {22809}                       , 9) ,
        Tuple.Create("mlog_22895"                                        , "Mission 5"   , "-Undock"                              , new int[] {22895}                       , -1) ,
        Tuple.Create("mlog_22810"                                        , "Mission 5"   , "-Trade Lane"                          , new int[] {22810}                       , -1) ,
        Tuple.Create("mlog_22815"                                        , "Mission 5"   , "-Trade Lane 2"                        , new int[] {22815}                       , -1) ,
        Tuple.Create("mlog_22820"                                        , "Mission 5"   , "-Jump"                                , new int[] {22820}                       , -1) ,
        Tuple.Create("mlog_22825"                                        , "Mission 5"   , "-Trade Lane 3"                        , new int[] {22825}                       , -1) ,
        Tuple.Create("mlog_22830"                                        , "Mission 5"   , "-Fly to Sprague"                      , new int[] {22830}                       , -1) ,
        Tuple.Create("mlog_22835"                                        , "Mission 5"   , "-Kill Rheinlanders"                   , new int[] {22835}                       , -1) ,
        Tuple.Create("mlog_22840"                                        , "Mission 5"   , "-Dock"                                , new int[] {22840}                       , -1) ,
        Tuple.Create("mlog_22855"                                        , "Mission 5"   , "-Fly to Baxter Station"               , new int[] {22855, 22850}                       , -1) ,
        Tuple.Create("mlog_22905"                                        , "Mission 5"   , "-Dock with Baxter"                    , new int[] {22905}                       , -1) ,
        Tuple.Create("mlog_meet_juni"                                    , "Mission 5"   , "-Undock"                              , new int[] {22930}                       , -1) ,
        Tuple.Create("mlog_22860"                                        , "Mission 5"   , "-Fight Rheinlanders"                  , new int[] {22860}                       , -1) ,
        Tuple.Create("mlog_22865"                                        , "Mission 5"   , "-Fly to Cambridge Hole"               , new int[] {22865}                       , -1) ,
        Tuple.Create("mlog_22867"                                        , "Mission 5"   , "-Jump"                                , new int[] {22867}                       , -1) ,
        Tuple.Create("mlog_22870"                                        , "Mission 5"   , "-Fly to waypoint"                     , new int[] {22870}                       , -1) ,
        Tuple.Create("mlog_22875"                                        , "Mission 5"   , "-Fly to Leeds Hole"                   , new int[] {22875}                       , -1) ,
        Tuple.Create("mlog_22910"                                        , "Mission 5"   , "-Boom"                                , new int[] {22910}                       , -1) ,
        Tuple.Create("mlog_22880"                                        , "Mission 5"   , "-Fight Rheinlanders"                  , new int[] {22880}                       , -1) ,
        Tuple.Create("mlog_22885"                                        , "Mission 5"   , "-Jump"                                , new int[] {22885}                       , -1) ,
        Tuple.Create("mlog_22890"                                        , "Mission 5"   , "-Go to Tradelane"                     , new int[] {22890}                       , -1) ,
        Tuple.Create("mlog_22893"                                        , "Mission 5"   , "-Take Tradelane"                      , new int[] {22893}                       , -1) ,
        Tuple.Create("mlog_22894"                                        , "Mission 5"   , "{Mission 5} Dock with Leeds"          , new int[] {22894}                       , -1) ,
        //Mission 5 Free time  //Due to the cutscene skip, this one is broken until you undock, and we normally hit level 11 before we undock, so I'm just gonna skip it
        //Tuple.Create("free_time5"                                        , "Free Time 5" , "Mission 5 Free Time"                  , new int[] {1231}                        , 10) ,
        //Mission 6
        Tuple.Create("no_id"                                             , "Mission 6"   , "-Fly to the Hood"                     , new int[] {23140, 23144}                       , 11) ,
        Tuple.Create("mlog_5475"                                         , "Mission 6"   , "-Go to the bar"                       , new int[] {23115}                       , -1) ,
        Tuple.Create("mlog_27"                                           , "Mission 6"   , "-Undock"                              , new int[] {23100}                       , -1) ,
        Tuple.Create("mlog_3"                                            , "Mission 6"   , "-Race"                           , new int[] {23015}                       , -1) ,
        Tuple.Create("mlog_22a"                                          , "Mission 6"   , "-Fly to the Hood"                     , new int[] {21660,23120}                       , -1) ,
        Tuple.Create("mlog_22b"                                          , "Mission 6"   , "-Dock & Undock"                       , new int[] {23146}                       , -1) ,
        Tuple.Create("mlog_23c"                                          , "Mission 6"   , "-Fly to Glorious"                     , new int[] {23040}                       , -1) ,
        Tuple.Create("mlog_24"                                           , "Mission 6"   , "-Defend Glorious"                     , new int[] {23045}                       , -1) ,
        Tuple.Create("mlog_25"                                           , "Mission 6"   , "-Dock with Glorious"                  , new int[] {23050}                       , -1) ,
        Tuple.Create("mlog_meetquint"                                    , "Mission 6"   , "-Undock"                              , new int[] {23085}                       , -1) ,
        Tuple.Create("nn_gonav1"                                         , "Mission 6"   , "-Fly to Waypoint"                     , new int[] {23130}                       , -1) ,
        Tuple.Create("nn_protect"                                        , "Mission 6"   , "-Protect Q"                           , new int[] {23060}                       , -1) ,
        Tuple.Create("nn_goBr04hole"                                     , "Mission 6"   , "-Fly to the Leeds hole"               , new int[] {23055}                       , -1) ,
        Tuple.Create("nn_killhostile"                                    , "Mission 6"   , "-Protect Q, take the hole"            , new int[] {23070}                       , -1) ,
        Tuple.Create("nn_23075"                                          , "Mission 6"   , "-Take Trade Lane"                     , new int[] {23075}                       , -1) ,
        Tuple.Create("nn_landleeds"                                      , "Mission 6"   , "{Mission 6} Leeds & Cutscene"         , new int[] {23080}                       , 11) ,
        //Mission 7
        Tuple.Create("mlog_fly_in_the_border_worlds_to_find_kress"       , "Mission 7"   , "-Go to the Border Worlds"             , new int[] {23215}                       , 12) ,
        Tuple.Create("mlog_destroy_the_rhineland_agents"                 , "Mission 7"   , "-Destroy Rheinlanders 1"              , new int[] {23220}                       , -1) ,
        Tuple.Create("mlog_take_the_tradelane_to_stokes"                 , "Mission 7"   , "-Tradelane"  , new int[] {23225}                       , -1) ,
        Tuple.Create("m7_no_id"                 , "Mission 7"   , "-Destroy Rheinlanders 2"  , new int[] {23230}                       , -1) ,
        Tuple.Create("mlog_take_the_tradelane_to_the_tau31_gate"         , "Mission 7"   , "-Tradelane to Tau31 Gate"             , new int[] {23235, 23349}                       , -1) ,
        Tuple.Create("mlog_destroy_the_rheinland_blockade_ships"         , "Mission 7"   , "-Destroy Rheinland Blockade"          , new int[] {23240}                       , -1) ,
        Tuple.Create("mlog_dock_with_the_jumpgate_to_tau31"              , "Mission 7"   , "-Jump"                                , new int[] {23245}                       , -1) ,
        Tuple.Create("mlog_take_the_tradelane_to_holman"                 , "Mission 7"   , "-Tradelane to Holman"                 , new int[] {23250}                       , -1) ,
        Tuple.Create("mlog_take_the_tradelane_to_the_tau29_gate"         , "Mission 7"   , "-Tradelane to Tau29"                  , new int[] {23255}                       , -1) ,
        Tuple.Create("mlog_fly_to_the_tradelane"                         , "Mission 7"   , "-Fly to Tradelane"                    , new int[] {23260}                       , -1) ,
        Tuple.Create("mlog_take_the_tradelane_to_the_tau23_gate"         , "Mission 7"   , "-Tradelane to Tau23"                  , new int[] {23265}                       , -1) ,
        Tuple.Create("mlog_meet_up_with_the_others_at_the_tau29_hole"    , "Mission 7"   , "-Go to Tau29 Hole"                    , new int[] {23270, 23275}                       , -1) ,
        Tuple.Create("mlog_take_the_jumphole_to_tau29"                   , "Mission 7"   , "-Jump"                                , new int[] {23280}                       , -1) ,
        Tuple.Create("mlog_fly_to_shinkaku"                              , "Mission 7"   , "-Fly to Shinkaku"                     , new int[] {23285}                       , -1) ,
        Tuple.Create("mlog_dock_with_shinkaku"                           , "Mission 7"   , "-Dock"                                , new int[] {23290}                       , -1) ,
        Tuple.Create("mlog_meet_quintaine_in_space_outside_shinkaku"     , "Mission 7"   , "-Undock"                              , new int[] {23348}                       , -1) ,
        Tuple.Create("mlog_fly_to_coordinate_of_kress_base"              , "Mission 7"   , "-Destroy Rheinlanders at Waypoint"                     , new int[] {23295,23300}                       , -1) ,
        //Weirdly, the below one is only activated if you die. Your objective doesn't update from the waypoint one above
        //Tuple.Create("mlog_help_the_order_destroy_the_rhineland_fleet"   , "Mission 7"   , "-Destroy Rheinlanders"                , new int[] {23300}                       , -1) ,
        Tuple.Create("mlog_rendezvous_with_quintaine_and_sinclair"       , "Mission 7"   , "-Go to Q"                             , new int[] {23305}                       , -1) ,
        Tuple.Create("mlog_fly_to_the_tau23_jumphole"                    , "Mission 7"   , "-Fly to Tau23 Hole"                   , new int[] {23310}                       , -1) ,
        Tuple.Create("mlog_dock_with_tau23_jumphole"                     , "Mission 7"   , "-Jump"                                , new int[] {23315}                       , -1) ,
        Tuple.Create("mlog_fly_to_kress_base"                            , "Mission 7"   , "-Fly to Cali Base"                    , new int[] {23320}                       , -1) ,
        Tuple.Create("mlog_land_on_cali_base"                            , "Mission 7"   , "-Dock"                                , new int[] {23325}                       , -1) ,
        Tuple.Create("mlog_launch_and_meet_razor_one_in_space"           , "Mission 7"   , "-Undock"                              , new int[] {23330}                       , -1) ,
        Tuple.Create("mlog_follow_razor_one_to_kyushu_jumphole"          , "Mission 7"   , "-Go to Kyushu Hole"                   , new int[] {23335}                       , -1) ,
        Tuple.Create("mlog_take_the_jumphole_to_the_kyushu_system"       , "Mission 7"   , "-Jump"                                , new int[] {23340}                       , -1) ,
        Tuple.Create("no_id"                                             , "Mission 7"   , "{Mission 7} Take Trade Lanes & Dock"  , new int[] {23345}                       , -1) ,
        //Mission 7 Free Time
        Tuple.Create("free_time5"                                        , "Free Time 5" , "Mission 7 Free Time"                  , new int[] {23347}                       , 13) , //Because of a skip , the objective doesn't get updated and this is actually the 'dock' objective :/
        //Mission 8
        Tuple.Create("mark_ku01_05"                                      , "Mission 8"   , "-Bar in Shinagawa"                    , new int[] {23410}                       , 14) ,
        Tuple.Create("launch"                                            , "Mission 8"   , "-Undock"                              , new int[] {23415}                       , -1) ,
        Tuple.Create("mark_ring"                                         , "Mission 8"   , "-Honshu Tradelane"                    , new int[] {22225}                       , -1) ,
        Tuple.Create("meet"                                              , "Mission 8"   , "-Fly to Waypoint"                     , new int[] {23420}                       , -1) ,
        Tuple.Create("Follow"                                            , "Mission 8"   , "-Take Hole"                           , new int[] {23425}                       , -1) ,
        Tuple.Create("search"                                            , "Mission 8"   , "-Head to Transport"                   , new int[] {23430}                       , -1) ,
        Tuple.Create("destroy_platforms"                                 , "Mission 8"   , "-Destroy Platforms"                   , new int[] {23433}                       , -1) ,
        Tuple.Create("defend_transport"                                  , "Mission 8"   , "-Defend Transport"                    , new int[] {23437}                       , -1) ,
        Tuple.Create("defend"                                            , "Mission 8"   , "-Kill Fighters"                       , new int[] {24030}                       , -1) ,
        Tuple.Create("land_end"                                          , "Mission 8"   , "{Mission 8} Go to & Land on Kyoto"    , new int[] {23440}                       , -1) ,
        //Mission 8 Free Time
        Tuple.Create("free_time6"                                        , "Free Time 6" , "Mission 8 Free Time"                  , new int[] {21660}                       , -1) ,
        //Mission 9
        Tuple.Create("no_id"                                             , "Mission 9"   , "-Bar in Kyoto"                        , new int[] {979}                         , -1) ,
        Tuple.Create("mlog_meet_ozu_in_space"                            , "Mission 9"   , "-Undock"                              , new int[] {23615}                       , -1) ,
        Tuple.Create("mlog_fly_to_the_jumphole"                          , "Mission 9"   , "-Fly to Tohoku Hole"                  , new int[] {23620}                       , -1) ,
        Tuple.Create("mlog_take_jumphole_to_tohoku"                      , "Mission 9"   , "-Take Hole"                           , new int[] {23625}                       , -1) ,
        Tuple.Create("mlog_fly_to_the_blood_dragon_outpost"              , "Mission 9"   , "-Fly to Ryuku"                        , new int[] {23630}                       , -1) ,
        Tuple.Create("mlog_go_to_tekagis_arch"                           , "Mission 9"   , "-Go to Waypoint"                      , new int[] {23635}                       , -1) ,
        Tuple.Create("mlog_destroy_the_tekagi_patrol"                    , "Mission 9"   , "-Destroy Patrol"                      , new int[] {23690}                       , -1) ,
        Tuple.Create("mlog_go_to_tekagis_arch_2"                         , "Mission 9"   , "-Go to Arch"                          , new int[] {23695}                       , -1) ,
        Tuple.Create("mlog_destroy_the_generators"                       , "Mission 9"   , "-Destroy Generators"                  , new int[] {23640}                       , -1) ,
        Tuple.Create("mlog_dock_with_arch"                               , "Mission 9"   , "-Dock"                                , new int[] {23645}                       , -1) ,
        Tuple.Create("mlog_fly_to_the_chugoku_jumphole"                  , "Mission 9"   , "-Fly to Waypoint"                     , new int[] {23670}                       , -1) ,
        Tuple.Create("mlog_destroy_the_rheinland_forces"                 , "Mission 9"   , "-Destroy Rheinlanders"                , new int[] {23680}                       , -1) ,
        Tuple.Create("mlog_fly_to_the_chugoku_jumphole_2"                , "Mission 9"   , "-Fly to Jumphole"                     , new int[] {23700}                       , -1) ,
        Tuple.Create("mlog_take_the_jumphole_back_to_ku06"               , "Mission 9"   , "-Take Hole"                           , new int[] {23650}                       , -1) ,
        Tuple.Create("mlog_return_to_the_dragonbase_with_akira"          , "Mission 9"   , "-Head to Kyoto"                       , new int[] {23655}                       , -1) ,
        Tuple.Create("mlog_dock_with_the_dragonbase"                     , "Mission 9"   , "{Mission 9} Dock"                     , new int[] {23660}                       , -1) ,
        //Mission 10
        Tuple.Create("NNObj_23810"                                       , "Mission 10"  , "-Meet Juni in the Bar"                , new int[] {23810}                       , -1) ,
        Tuple.Create("NNObj_23815"                                       , "Mission 10"  , "-Undock"                              , new int[] {23815}                       , -1) ,
        Tuple.Create("NNObj_23820"                                       , "Mission 10"  , "-Fly to Sigma-13 Hole"                , new int[] {23820}                       , -1) ,
        Tuple.Create("NNObj_23825"                                       , "Mission 10"  , "-Take hole"                           , new int[] {23825}                       , -1) ,
        Tuple.Create("NNObj_23830"                                       , "Mission 10"  , "-Fly to Waypoint"                     , new int[] {23830}                       , -1) ,
        Tuple.Create("NNObj_23832"                                       , "Mission 10"  , "-Fight Rheinlanders"                  , new int[] {23832}                       , -1) ,
        Tuple.Create("NNObj_23833"                                       , "Mission 10"  , "-Fly to New Berlin Hole"              , new int[] {23833}                       , -1) ,
        Tuple.Create("NNObj_23835"                                       , "Mission 10"  , "-Take hole"                           , new int[] {23835}                       , -1) ,
        Tuple.Create("NNObj_23840"                                       , "Mission 10"  , "-Take Tradelane"                      , new int[] {23840}                       , -1) ,
        Tuple.Create("NNObj_23845"                                       , "Mission 10"  , "-Dock & Undock New Berlin"            , new int[] {23845}                       , -1) ,
        Tuple.Create("NNObj_23860"                                       , "Mission 10"  , "-Take Tradelane to Frankfurt Gate"    , new int[] {23860}                       , -1) ,
        Tuple.Create("NNObj_23865"                                       , "Mission 10"  , "-Jump"                                , new int[] {23865}                       , -1) ,
        Tuple.Create("NNObj_23870"                                       , "Mission 10"  , "-Take Tradelanes"                     , new int[] {23870}                       , -1) ,
        Tuple.Create("NNObj_23875"                                       , "Mission 10"  , "-Dock at Holstein"                    , new int[] {23875}                       , -1) ,
        Tuple.Create("NNObj_23880"                                       , "Mission 10"  , "-Fly to Bruchsal"                     , new int[] {23880}                       , -1) ,
        Tuple.Create("NNObj_23885"                                       , "Mission 10"  , "-Defend Bruchsal"                     , new int[] {23885}                       , -1) ,
        //TODO: Separate these if possilbe
        Tuple.Create("NNObj_23890"                                       , "Mission 10"  , "-Dock, Undock & Fly Through Field"    , new int[] {23890}                       , -1) ,
        Tuple.Create("NNObj_23910"                                       , "Mission 10"  , "-Destroy Experimental Battleship"     , new int[] {23910}                       , -1) ,
        Tuple.Create("B_Jump_Hole"                                       , "Mission 10"  , "-Take Hamburg Hole"                   , new int[] {23915}                       , -1) ,
        Tuple.Create("NNObj_23925"                                       , "Mission 10"  , "-Don't die"                           , new int[] {23925}                       , -1) ,
        Tuple.Create("NNObj_23930"                                       , "Mission 10"  , "{Mission 10} Dock with Osiris"        , new int[] {23930}                       , -1) ,
        //Mission 11
        Tuple.Create("mlog_0"                                            , "Mission 11"  , "-Undock"                              , new int[] {24015}                       , -1) ,
        Tuple.Create("mlog_1"                                            , "Mission 11"  , "-Go to NY Hole"                       , new int[] {24020}                       , -1) ,
        Tuple.Create("mlog_2"                                            , "Mission 11"  , "-Take Hole"                           , new int[] {24025}                       , -1) ,
        Tuple.Create("mlog_3"                                            , "Mission 11"  , "-Destroy Navy"                        , new int[] {24030}                       , -1) ,
        Tuple.Create("mlog_4"                                            , "Mission 11"  , "-Head to Buffalo Base"                , new int[] {24035}                       , -1) ,
        Tuple.Create("mlog_5"                                            , "Mission 11"  , "-Dock"                                , new int[] {24040}                       , -1) ,
        Tuple.Create("mlog_27"                                           , "Mission 11"  , "-Undock"                              , new int[] {24037}                       , -1) ,
        Tuple.Create("mlog_6"                                            , "Mission 11"  , "-Fly to the NY Hole"                  , new int[] {24045}                       , -1) ,
        Tuple.Create("mlog_7"                                            , "Mission 11"  , "-Jump"                                , new int[] {24125}                       , -1) ,
        Tuple.Create("mlog_8"                                            , "Mission 11"  , "-Fly to Satellite"                    , new int[] {24050}                       , -1) ,
        Tuple.Create("mlog_9"                                            , "Mission 11"  , "-Destroy the Satellite"               , new int[] {24055}                       , -1) ,
        Tuple.Create("mlog_10"                                           , "Mission 11"  , "-Destroy Fighters"                    , new int[] {24140}                       , -1) ,
        Tuple.Create("mlog_11"                                           , "Mission 11"  , "-Head to Walker"                      , new int[] {24060}                       , -1) ,
        Tuple.Create("mlog_13"                                           , "Mission 11"  , "-Form up with Walker"                 , new int[] {24065}                       , -1) ,
        Tuple.Create("mlog_15"                                           , "Mission 11"  , "-Destroy Fighter Group 1"             , new int[] {24070}                       , -1) ,
        Tuple.Create("mlog_12"                                           , "Mission 11"  , "-Destroy Fighter Group 2"             , new int[] {24075}                       , -1) ,
        Tuple.Create("mlog_17"                                           , "Mission 11"  , "-Take the Alaska Gate"                , new int[] {24080}                       , -1) ,
        Tuple.Create("mlog_18"                                           , "Mission 11"  , "-Fly to Mitchell"                     , new int[] {24085}                       , -1) ,
        Tuple.Create("mlog_19"                                           , "Mission 11"  , "-Dock with Mitchell"                  , new int[] {24100}                       , -1) ,
        Tuple.Create("mlog_20"                                           , "Mission 11"  , "-Go to waypoint"                      , new int[] {24105}                       , -1) ,
        Tuple.Create("mlog_16"                                           , "Mission 11"  , "-Defend"                              , new int[] {24107}                       , -1) ,
        Tuple.Create("mlog_21"                                           , "Mission 11"  , "-Take Gate"                           , new int[] {24110}                       , -1) ,
        Tuple.Create("mlog_22"                                           , "Mission 11"  , "-Fly to Waypoint"                     , new int[] {24115}                       , -1) ,
        Tuple.Create("mlog_26"                                           , "Mission 11"  , "-Defend"                              , new int[] {24117}                       , -1) ,
        Tuple.Create("mlog_24"                                           , "Mission 11"  , "{Mission 11} Dock with Osiris"        , new int[] {24120}                       , -1) ,
        //Mission 12
        Tuple.Create("mlog_mission_accept"                               , "Mission 12"  , "-Undock"                              , new int[] {24215}                       , -1) ,
        Tuple.Create("mlog_goto_the_lair"                                , "Mission 12"  , "-Fly to the Lair"                     , new int[] {24220}                       , -1) ,
        Tuple.Create("mlog_destroy_the_shield"                           , "Mission 12"  , "-Destroy the Generators"              , new int[] {24223}                       , -1) ,
        Tuple.Create("mlog_above_the_airlock"                            , "Mission 12"  , "-Go to Airlock"                       , new int[] {24224}                       , -1) ,
        Tuple.Create("mlog_goto_the_airlock"                             , "Mission 12"  , "-Go into Airlock"                     , new int[] {24225}                       , -1) ,
        Tuple.Create("mlog_get_the_powercell"                            , "Mission 12"  , "-Get the Power Cell"                  , new int[] {24230}                       , -1) ,
        Tuple.Create("mlog_exit_the_core"                                , "Mission 12"  , "-Leave"                               , new int[] {24240}                       , -1) ,
        Tuple.Create("mlog_jump_back_to_st01"                            , "Mission 12"  , "-Run to the hole"                     , new int[] {24250}                       , -1) ,
        Tuple.Create("mlog_dock_with_jumphole"                           , "Mission 12"  , "-Jump"                                , new int[] {24255}                       , -1) ,
        Tuple.Create("mlog_return_to_the_orderbase"                      , "Mission 12"  , "-Head to Toledo"                      , new int[] {24260}                       , -1) ,
        Tuple.Create("mlog_land_on_the_base"                             , "Mission 12"  , "{Mission 12} Land on Toledo"          , new int[] {24275}                       , -1) ,
        //Mission 13
        Tuple.Create("defend_base"                                       , "Mission 13"  , "-Defend the Base"                     , new int[] {24414}                       , -1) ,
        Tuple.Create("Cap1"                                              , "Mission 13"  , "-Kill Battleship 1"                   , new int[] {24425}                       , -1) ,
        Tuple.Create("go_home"                                           , "Mission 13"  , "-Dock & Undock"                       , new int[] {24430}                       , -1) ,
        Tuple.Create("escort_sinclair_ids"                               , "Mission 13"  , "-Escort Sinclair"                     , new int[] {24440}                       , -1) ,
        Tuple.Create("dock_with_osiris"                                  , "Mission 13"  , "-Dock"                                , new int[] {24445}                       , -1) ,
        Tuple.Create("meet_orillion"                                     , "Mission 13"  , "-Undock"                              , new int[] {24450}                       , -1) ,
        Tuple.Create("run_to_gate"                                       , "Mission 13"  , "-Go to Nomad Gate"                    , new int[] {24455}                       , -1) ,
        Tuple.Create("take_out_nomads"                                   , "Mission 13"  , "-Kill Nomads"                         , new int[] {24460}                       , -1) ,
        Tuple.Create("lead_through_gate"                                 , "Mission 13"  , "-Jump"                                , new int[] {24465}                       , -1) ,
        Tuple.Create("head_to_sphere"                                    , "Mission 13"  , "-Go to the Dyson Sphere"              , new int[] {24470}                       , -1) ,
        Tuple.Create("destroy_generators"                                , "Mission 13"  , "-Destroy Generators"                  , new int[] {24485}                       , -1) ,
        Tuple.Create("penetrate"                                         , "Mission 13"  , "-Enter the Sphere"                    , new int[] {24475}                       , -1) ,
        Tuple.Create("head_to_city"                                      , "Mission 13"  , "{Mission 13} Destroy City Generators" , new int[] {22235}                       , -1) ,
    };
    var addedParents = new List<string>();
//    settings.Add("Force Skip On Levelup");
    for (int i = 0; i < vars.autoSplits.Length; i++) {
        if (!addedParents.Contains(vars.autoSplits[i].Item2)) {
            settings.Add(vars.autoSplits[i].Item2);
            addedParents.Add(vars.autoSplits[i].Item2);
        }
        settings.Add("autosplit_"+i.ToString(),true,"Split on \""+vars.autoSplits[i].Item3, vars.autoSplits[i].Item2);
//        if (vars.autoSplits[i].Item5 > 0) {
//            settings.Add("autosplit_level_skip"+i.ToString(), true, "Skip to split '" + vars.autoSplits[i].Item2 + vars.autoSplits[i].Item3 + "' when levelling up to rank " + vars.autoSplits[i].Item5, "Force Skip On Levelup");
//        }
    }
}

init {
// run when the game is found, do any needed initialization here
    // resume game time on process start
    // timer.IsGameTimePaused = false;
    print("Game started");
    if (vars.autoSplitIndex == -1) {
        for (vars.autoSplitIndex = 0;vars.autoSplitIndex < vars.autoSplits.Length;++vars.autoSplitIndex) {
            if (settings["autosplit_"+vars.autoSplitIndex.ToString()]) {
                break;
            }
        }
    }
}

update {
    //If the user manually starts the timer, just assume that the game is running so autosplits will work
    if (timer.CurrentPhase.ToString() == "Running") vars.gameHasStarted = true;
    if (vars.gameHasStarted && timer.CurrentSplitIndex > 0) {
        //If the user skips ahead a split, we should follow so autosplits still work
        if (vars.gameHasStarted && vars.autoSplitIndex != timer.CurrentSplitIndex) {
            vars.autoSplitIndex = timer.CurrentSplitIndex;
        }
        //server.dll gets reloaded regularly so we need to dynamically update the location of it - This isn't 100% accurate but is a decent idea of what the players level is
        vars.prev_player_level = vars.player_level;
        vars.player_level = new DeepPointer("server.dll", 0xACFC0, 0x284).Deref<int>(game);
        // TODO: Clean this up
//        for (int i = vars.autoSplitIndex; i < vars.autoSplits.Length; i++) {
//            // Find the next potential levelup skip
//            if (vars.autoSplits[i].Item5 > 0 && settings["autosplit_level_skip"+i]) {
//                vars.next_level_skip = i;
//                vars.skip_at_level = vars.autoSplits[i].Item5;
//                break;
//            } else {
//                vars.next_level_skip = null;
//                vars.skip_at_level = null;
//            }
//        }
    }
    //If we've levelled up, and that level is equal to the skip level, and the autosplitter is behind where it should be, set the skip up
    //Potentially do "vars.prev_player_level < vars.player_level && " here to make sure we JUST levelled up?
//    if (vars.player_level == vars.skip_at_level && vars.autoSplitIndex <= vars.next_level_skip) {
//        // If we're only going by one, just split normally because it's probably just a simple level up
//        if (vars.next_level_skip - vars.autoSplitIndex == 1) {
//            vars.timerModel.Split();
//        } else {
//            // If we're going up by more than one, start skipping splits because we probably missed an autosplit and we need to catch up
//            vars.timerModel.SkipSplit();
//        }
//    }
}

shutdown
{
    // run when the script is stopped
}


exit
{
    // run when the game process is lost
    // pause game time on crash / exit
    // timer.IsGameTimePaused = true;
}

start
{
    // return true when you want to start the splits
    if (vars.gameHasStarted == false) print("Waiting on new game: " + current.in_game);
    if (vars.gameHasStarted == false && current.in_game == 1) {
        print("Game has started, starting timer");
        vars.gameHasStarted = true;
        return true;
    }
}

reset
{
    // return true when you want to reset the splits
    //I've not figured out a nice way to work out if we're actually starting a new run or not - especially
    //  since I often use 'New Game' to show a space scene to fix my resolution. So this has to be manual
    //  for now.
}

split
{
    // If we need to get to a particular split, skip to it
    if (vars.autoSplitIndex < vars.autoSplits.Length) {
        print("Current split index: " + vars.autoSplitIndex + " / " + vars.autoSplits.Length + " ( Livesplit index: " + timer.CurrentSplitIndex + ") | Current objective: " + current.nn_objective_id + " | Looking for objective " + string.Join(",",vars.autoSplits[vars.autoSplitIndex].Item4) + " | Player Level: " + vars.player_level + " (Ptr: " + modules.First(x => x.ModuleName == "server.dll").BaseAddress + " ) | Next skip is at level " + vars.skip_at_level + " to index " + vars.next_level_skip);
    }
    if (vars.autoSplitIndex < vars.autoSplits.Length) {
        if (Array.IndexOf(vars.autoSplits[vars.autoSplitIndex].Item4, current.nn_objective_id) != -1) {
            for (++vars.autoSplitIndex;vars.autoSplitIndex < vars.autoSplits.Length;++vars.autoSplitIndex) {
               if (settings["autosplit_"+vars.autoSplitIndex.ToString()]) {
                    break;
                }
            }
            //print("Seen objective " + vars.autoSplits[vars.autoSplitIndex].Item1 );
            return true;
        }
    }
    // Ending cutscene
    if (vars.autoSplitIndex == vars.autoSplits.Length && current.player_lost_control == 1) {
        return true;
    }
    return false;
}

//isLoading
//{
    // return true when you want to pause the game time

//    return current.isLoading;
//}