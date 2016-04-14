--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import CountVonCount.Persistence


--------------------------------------------------------------------------------
main :: IO ()
main = do
    db <- newDatabase "count-von-count.db"
    deleteAll db

    -- Define stations
    -- TODO 2 more gyrids
    addStation db "gyrid112" "00:01:95:0d:cf:eb" 0
    addStation db "gyrid101" "00:01:95:0d:cf:e7" 40
    addStation db "gyrid113" "00:01:95:0d:cf:e4" 80
    addStation db "gyrid103" "00:01:95:0a:cc:3f" 120
    addStation db "gyrid104" "00:01:95:0a:56:01" 160

    -- Define teams
    t1  <- addTeam db "HILOK"
    t2  <- addTeam db "VGK"
    t3  <- addTeam db "VTK"
    t4  <- addTeam db "VLK"
    t5  <- addTeam db "VRG"
    t6  <- addTeam db "VEK & Moeder Lies"
    t7  <- addTeam db "VPPK"
    t8  <- addTeam db "Hermes & LILA"
    t9  <- addTeam db "Wetenschappen & VLAK"
    t10 <- addTeam db "VBK"
    t11 <- addTeam db "HK"
    t12 <- addTeam db "SK"
    t13 <- addTeam db "Zeus WPI"

    -- Define batons
    b1  <- addBaton db "20:13:01:24:11:15" "Baton A"
    b2  <- addBaton db "20:13:01:30:03:69" "Baton B"
    b3  <- addBaton db "20:13:02:20:15:11" "Baton D"
    b4  <- addBaton db "20:13:01:24:10:46" "Baton E"
    b5  <- addBaton db "20:13:01:24:00:43" "Baton F"
    b6  <- addBaton db "20:13:02:21:01:04" "Baton G"
    b7  <- addBaton db "20:13:02:18:02:86" "Baton H"
    b8  <- addBaton db "20:13:02:19:15:17" "Baton I"
    b9  <- addBaton db "20:13:01:31:01:32" "Baton J"
    b10 <- addBaton db "20:13:02:20:16:95" "Baton K'"
    b11 <- addBaton db "20:13:01:24:00:28" "Baton L"
    b12 <- addBaton db "20:11:02:15:01:90" "Baton M"
    b13 <- addBaton db "20:11:02:15:01:67" "Baton N"
    b14 <- addBaton db "00:12:02:01:00:04" "Baton P"
    b15 <- addBaton db "00:12:02:01:08:76" "Baton Q"
    b16 <- addBaton db "20:11:02:15:01:93" "Baton R"
    b17 <- addBaton db "20:11:02:15:01:77" "Baton T"
    b18 <- addBaton db "20:11:02:15:01:34" "Baton U"
    b19 <- addBaton db "00:12:02:01:06:25" "Baton W"
    b20 <- addBaton db "00:12:02:01:07:82" "Baton X"
    b21 <- addBaton db "20:11:02:15:01:79" "Baton Y"
    b22 <- addBaton db "20:13:12:06:90:49" "Baton Z"

    -- Connect teams to batons
    setTeamBaton db t1  $ Just b1
    setTeamBaton db t2  $ Just b2
    setTeamBaton db t3  $ Just b3
    setTeamBaton db t4  $ Just b4
    setTeamBaton db t5  $ Just b5
    setTeamBaton db t6  $ Just b6
    setTeamBaton db t7  $ Just b7
    setTeamBaton db t8  $ Just b8
    setTeamBaton db t9  $ Just b9
    setTeamBaton db t10 $ Just b10
    setTeamBaton db t11 $ Just b11
    setTeamBaton db t12 $ Just b12
    setTeamBaton db t13 $ Just b13

    closeDatabase db
