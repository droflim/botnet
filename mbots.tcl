# mbots.tcl
#
# made by guruz@ircnet. http://www.guruz.de/mbots/
#
# questions? mail guruz@guruz.de
#
#
##################################################################################
### Settings
##################################################################################


set mb_key "changethis"
set mb_partmsg "\002mbots\002"
set mb_botnetlogo "\002mbots\002"
set mb_superbitchkickglobalops 0
set mb_commandbroadcast 1







##################################################################################
### Do not edit anything below this line!
##################################################################################


















##################################################################################
### Log Function
##################################################################################

proc mbots_log { data } {
  putlog "\[\002mbots\002\] $data"
}

##################################################################################
### init
##################################################################################

mbots_log "Initalizing mbots.tcl"
set got_host 0
set mb_botflag "M"

##################################################################################
### Util functions
##################################################################################

proc slindex {string n} {
  return [lindex [split $string] $n]
}
 
proc stl {string} {
  return [string tolower $string]
} 

proc mbotslogo { } {
  global mb_botnetlogo
  return "$mb_botnetlogo"
}

proc multichars { char line } {
 return ""
}


proc mbots_duration {time} {
# This proc is based on that used in Bass's Seen script (http://bseen.tclslave.net)
  set years 0 ; set days 0 ; set hours 0 ; set mins 0
  if {$time < 60} {return "< 1 min"}
  if {$time >= 31536000} {
    set years [expr int([expr $time/31536000])] ; set time [expr $time - [expr 31536000*$years]]
  }
  if {$time >= 86400} {
    set days [expr int([expr $time/86400])] ; set time [expr $time - [expr 86400*$days]]
  }
  if {$time >= 3600} {
    set hours [expr int([expr $time/3600])] ; set time [expr $time - [expr 3600*$hours]]
  }
  if {$time >= 60} {
    set mins [expr int([expr $time/60])]
  }
  if {$years == 0} {
    set output ""
  } elseif {$years == 1} {
    set output "1 yr,"
  } else {
    set output "$years yrs,"
  }
  if {$days == 1} {
    lappend output "1 day,"
  } elseif {$days > 1} {
    lappend output "$days days,"
  }
  if {$hours == 1} {
    lappend output "1 hr,"
  } elseif {$hours > 1} {
    lappend output "$hours hrs,"
  }
  if {$mins == 1} {
    lappend output "1 min"
  } elseif {$mins > 1} {
    lappend output "$mins mins"
  }
  return [string trimright [join $output] ", "]
}

proc mbots_conf { item } {
 global mb_randomrealname mb_ishub mb_norandreal
 if {$item == "mb_randomrealname"} {
  if {[info exists mb_randomrealname]} {
    return $mb_randomrealname
   } else {
    return 1
  } 
 }
 if {$item == "mb_ishub"} {
  if {[info exists mb_ishub]} {
    return $mb_ishub
   } else {
    return 0
  } 
 }
 if {$item == "mb_stealth"} {
  if {[info exists mb_stealth]} {
    return $mb_stealth
   } else {
    return 0
  } 
 }

}


##################################################################################
### Fun functions everyone really needs ;)
##################################################################################

proc randmsg { kind } {
 set returnval "bla"
 if {$kind == "part"} {
   set msgs {
    {d3wdz..}
    {lamers..}
    {this suxx}
    {d3wdz..}
    {back in a few...}
    {y0y0}
    {l4m3rZ}
    {learn to ph33r me}
    {go away}
    {lame channel anyway}
    {lol}
   }
 }
 if {$kind == "aidle"} {
   set msgs {
    {:)}
    {;)}
    {:P}
    {ye ye ye}
    {arf}
    {*yawn*}
    {bleh}
    {:((}
    {H3h3h3!}
    {brb}
    {re}
   }
 }
 if {$kind == "away"} {
   set msgs {
    {eating}
    {sleeping}
    {i am gone, icq me on 0190906090}
    {not available}
    {ficken}
    {getting jiggy with it}
    {away}
    {Gone}
    {Gone}
    {Gone}
    {away}
    {Gone}
    {Gone}
    {Gone}
    {away}
    {Gone}
    {Gone}
    {Gone}
    {away}
    {Gone}
    {Gone}
    {Gone}
    {auto away after 20 minutes idle}
    {auto away after 30 minutes idle}
    {auto away after 15 minutes idle}
    {auto away after 60 minutes idle}  
    {Gone}
    {}
    {is an IRC OP}
   }
 }
 if {$kind == "realname"} {
   set msgs {
    {* I'm too lame to read BitchX.doc *}
    {hi}
    {A evil product of decoded rangers}
    {mIRC 69 by K. Mardam-Gay}
    {Bitch-X baby!}
    {BitchX Bitching}   
    {This /whois has been logged.}
    {Thomas Alva Edison}
    {Albert Einstein}
    {Josef Stalin}
    {Osman Bin Laden}
    {* I'm too lame to read BitchX.doc *}
    {I wanna Phuck Britney SpearZ}
    {If you really want to know just ask ?}
    {ask}
    {curious?}
    {JuSt aNo7ThEr eLiTe aSSh0L3}
    {* I'm too lame to read BitchX.doc *}
    {VERECKE!}
    {Bis du verfaulst !}
    {Ich pisse auf dich}
    {* I'm too lame to read BitchX.doc *}
    {Die!}
    {Die!}
    {Die!}
    {ASK ME OR FUCK OFF IF U WANNA KNOW}
    {sweat baby sweat ...}
    {Stirb!}
    {go away.}
    {bleh}
    {Not entered}
    {* I'm too lame to read BitchX.doc *}
    {* I'm too lame to read BitchX.doc *}
    {* I'm too lame to read BitchX.doc *}
    {* I'm too elite to read BitchX.doc *}
    {* I'm too cool to read mIRC.hlp *}
    {KVirc 0.9 by Pragma@ircnet}
    {mIRC 5.8 User}
    {WebChat User}
    {Enter your name here}
    {just another d3wd ...}
    {* I'm too lame to read BitchX.doc *}
    {http://www.ircnet.org}
    {wanna fuck?}
    {http://www.irc.net}
     {öhm ficken?}
    {...}
    {.}
    {ice ice baby too cold too cold}
   }
 }

 set returnval [lindex $msgs [expr [rand [llength $msgs]] + 0 ]]
}

proc randstring {length} {
  set chars abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
  set count [string length $chars]
  set randstr ""
  for {set i 0} {$i < $length} {incr i} { append randstr [string index $chars [rand $count]] }
  return $randstr
} 

proc randnick { } {
  global nick
  set newnick [string range $nick 0 2]
  append newnick [randstring 6]
}

##################################################################################
### Encryption and decryption
##################################################################################

proc mbots_encrypt { data } {
 global mb_key
 return [ encrypt $mb_key "$data"]
}

proc mbots_decrypt { data } {
 global mb_key
 return [ decrypt $mb_key "$data"]
}

##################################################################################
### Info things
##################################################################################
proc mbots_botnick { } {
 global nick botnet-nick
 if {! [info exists botnet-nick] } {
    return $nick
 } elseif { ${botnet-nick} != "" } {
    return $nick
 } else {
    return ${botnet-nick}
 }
 
}

proc mbots_getinfo { } {
  global mbots_version version owner
  catch {string trim [exec uptime]} uptime
  if {[info exists uptime]} {
    regsub -all -- "  " $uptime " " uptime
    return "[mbots_botnick] : Running mbots $mbots_version on eggdrop $version. Owner: $owner"
  }
}

proc mbots_getshells { } {
  catch {string trim [exec uptime]} uptime
  if {[info exists uptime]} {
    regsub -all -- "  " $uptime " " uptime
    return "[mbots_botnick] : [info hostname] - [unames] - $uptime"
  }
}

proc mbots_getserver { } {
   global server server-online botnet-nick realserver
   if { $server == "" } {
    return "${botnet-nick} : Not connected to a server." 
   } else {
    if {![info exists realserver]} {
      return "${botnet-nick} : Connected to $server since [mbots_duration [expr [unixtime] - ${server-online}]]."
    } else {
      return "${botnet-nick} : Connected to $server ($realserver) since [mbots_duration [expr [unixtime] - ${server-online}]]."
    }
   }
}

proc mbots_nick { } {
   global nick
   set nick [randnick]
}


##################################################################################
### Channel issues
##################################################################################

proc ischansettingset { chan setting } {
 set retval 0
  if { [validchan $chan] } {
   foreach info [channel info ${chan}] {
    if {$info == $setting} {set retval 1}
   }
  }
 return $retval
}

proc isinvonly { chan } {
 return [regexp "i+" [getchanmode $chan]]
}

proc mbots_addchantohub { chan } {
  global mb_myhub
  if {[mbots_conf mb_ishub]} {
    mbots_addinactivechan $chan
  } else {
    putbot $mb_myhub "mbotsrep 0 addhubchan [mbots_encrypt $chan]"
  }
}

proc mbots_addinactivechan { chan } {
  if {![validchan $chan]} {
   channel add $chan { +inactive }
   channel set $chan need-op "gain_entrance op $chan"
   channel set $chan need-key "gain_entrance key $chan"
   channel set $chan need-invite "gain_entrance invite $chan"
   channel set $chan need-unban "gain_entrance unban $chan"
   channel set $chan need-limit "gain_entrance limit $chan"
  }
   savechannels
}

proc mbots_addchan { chan } {
  if {![validchan $chan]} {
     channel add $chan
  } else {
     channel set $chan -inactive
  }
   channel set $chan need-op "gain_entrance op $chan"
   channel set $chan need-key "gain_entrance key $chan"
   channel set $chan need-invite "gain_entrance invite $chan"
   channel set $chan need-unban "gain_entrance unban $chan"
   channel set $chan need-limit "gain_entrance limit $chan"
   savechannels
}

proc mbots_removechan { chan } {
  global mb_partmsg
  if {[validchan $chan]} {  
     #putserv "PART $chan :[randmsg part]"
     putserv "PART $chan :$mb_partmsg"
     channel set $chan +inactive
  }
}

proc mbots_delchan { chan } {
  if {[validchan $chan]} {  
     putserv "PART $chan :\002-( ice ice baby )-\002"
     channel remove $chan
  }
}


proc mbots_chanset { chan rest } {
  if {[validchan $chan]} {
    eval channel set $chan $rest
  }
}

proc mbots_getchans {  } {
  global botnet-nick server
  set allchans [channels]
  set activechans ""
  set onchans ""
  set notonchans ""
  set newonchans ""
  foreach chan $allchans {
   set active 0
   if {[ischansettingset $chan "-inactive"]} { lappend activechans ${chan}}
  }



  foreach chan $activechans {
    if {[botonchan ${chan}]} {
      if {[botisvoice ${chan}]} {
         set blachan "+${chan}"
      }
      if {[botisop $chan]} {
         set blachan "@${chan}"
      } 
      if {(![botisop $chan]) && (![botisvoice ${chan}])} {
         set blachan "${chan}"
      }
      lappend onchans $blachan
    } else {
     lappend notonchans "${chan}"
    }
  }

  set activecount [llength $activechans]
  set oncount [llength $onchans]

  set retval "${botnet-nick} : \002Active:\002 $activecount \002On:\002 $oncount \002Chans:\002 [join $onchans]"
  if { [llength $notonchans] > 0 } {
   append retval " \002Not on:\002 [join $notonchans]"
  }

  if {$server == ""} { 
   set retval "${botnet-nick} : \002Not connected to server\002"
  }
  return $retval
}

### "War" Stuff

proc randlist { liste } {
  set newlist ""
  set listhad ""
  set i 0
  set listcount [llength $liste]
  set vorhercount $listcount
  while {$i < $vorhercount} {
   set randnum [rand $listcount]
   lappend newlist [lindex $liste $randnum]
   set liste [lreplace $liste $randnum $randnum ]
   incr listcount -1
   incr i
  }
 return $newlist
}

proc mbots_getchanlusers { chan } {
  if {$chan == ""} { return 0}
  if {![botonchan $chan]} {return 0}
  set chanlusers ""
  foreach user [chanlist $chan] {
    if {([isbotnick $user] == 0) && ([matchattr [nick2hand $user] "o|o" $chan] == 0)} {
     lappend chanlusers $user
    }
  }
  return $chanlusers
}

proc mbots_masskick { chan } {
  global mbots_currentmasskick
  if {$mbots_currentmasskick == ""} {
     set mbots_currentmasskick $chan
     mbots_masskick $chan
  } else {
    if {[botisop $chan]} {
      set chanusers ""
      set chanlusers [mbots_getchanlusers $chan]
      if {[llength $chanlusers] > 0} {
        set chanlusers [randlist $chanlusers]
        set luser1 [lindex $chanlusers 0]
        set luser2 [lindex $chanlusers 1]
        set luser3 [lindex $chanlusers 2]
        set luser4 [lindex $chanlusers 3]
        putlog "Kicking from $chan : $luser1 $luser2 $luser3, $luser4"
        putkick $chan $luser1,$luser2,$luser3,$luser4 "\002\002"
        utimer [expr 3 + [rand 5]] "mbots_masskick $mbots_currentmasskick"
      } else {
        set mbots_currentmasskick ""
      }
    }
  }

}



### Saying issues


proc mbots_say { dest msg } {
  putserv "PRIVMSG $dest :$msg"
}

proc mbots_notice { dest msg } {
  putserv "NOTICE $dest :$msg"
}

proc mbots_act { dest msg } {
  putserv "PRIVMSG $dest :\001ACTION $msg\001"
}

proc mbots_ctcp { dest cmd params } {
  if { !($params == "") } {
    putserv "PRIVMSG $dest :\001$cmd $params\001"
  } else {
    putserv "PRIVMSG $dest :\001$cmd\001"
  }
}

##################################################################################
### Server issues
##################################################################################

proc mbots_dump { arg } {
  putserv "$arg"
}

##################################################################################
### DCC Comands
##################################################################################

bind dcc n mhelp mbots_dcc_mhelp
proc mbots_dcc_mhelp {hand idx arg} {
putcmdlog "#$hand# mhelp $arg"
global mbots_commands

putidx $idx "mbots.tcl commands for [mbotslogo]"
putidx $idx ""
putidx $idx "\002BOTNET\002"
putidx $idx ".mhelp                                 This help command"
putidx $idx ".mping                                 Display botnet lag"
putidx $idx ".minfo                                 Display info about the mbots script"
putidx $idx ".mshell                                Display info about shells we are running on"
putidx $idx ".mhash                                 Rehash the net"
putidx $idx ".mjoin <chan>                          Add channel to net"
putidx $idx ".mpart <chan>                          Part channel by setting it to +inactive"
putidx $idx ".mdelchan <chan>                       Delete channel from net"
putidx $idx ".mnick                                 Change nick to some random stuff"
putidx $idx ".mchanset <chan> <setting>             Change channel settings on on the net"
putidx $idx ".mchans                                Active & chans we are on the net"
putidx $idx ".mchanclose <chan>                     Close a channel on the net (set +mis and mass kick)"
putidx $idx ".msay <chan|nick> <string>             Let the net say something"
putidx $idx ".mnotice <chan|nick> <string>          Let the net notice something"
putidx $idx ".mact <chan|nick> <string>             Let the net /me something"
putidx $idx ".mctcp <cmd> <chan|nick> \[<param>]\     Let the net do a CTCP"
putidx $idx ".mdump <string>                        Dump something to the server"
putidx $idx ".mserver                               Display servers we are on"
putidx $idx ".mcontrol                              Change the bots you are currently speaking to"
putidx $idx ".mupdate                               Update the mbots.tcl on leafs (PERM OWNER ONLY)"
putidx $idx ""
putidx $idx "\002LOCAL\002"
putidx $idx ".ctcp <cmd> <chan|nick> \[<param>]\      Send a CTCP"
putidx $idx ".addhub <nick> <host:port>             Add the botnet main hub"
putidx $idx ".addalthub <nick> <host:port>          Add the botnet alt hub"
putidx $idx ".addleaf <nick>                        Add a leaf bot"
putidx $idx ".opall                                 Ops you on all channels you are on"
putidx $idx ".inviteall                             Invites you to all channels"
putidx $idx ""
putidx $idx "\002NEW CHANNEL MODES\002"
putidx $idx "+superbitch                            Kicks opped user and opper (Local/Channel +E oppers are exempt)"
putidx $idx "+idledeop                              Deops opped users after 200 minutes idle"
putidx $idx ""
}   


bind dcc n mping mbots_dcc_mping
set mbots_commands(mping) "mping"
proc mbots_dcc_mping {hand idx arg} {
putcmdlog "#$hand# mping $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X ping [ mbots_encrypt "[unixtime]"]"
}   

bind dcc n minfo mbots_dcc_minfo
proc mbots_dcc_minfo {hand idx arg} {
putcmdlog "#$hand# minfo $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X info [ mbots_encrypt " "]"
if {[meincontrol $idx]} { putidx $idx "[mbots_getinfo]" }
}   

bind dcc n mshells mbots_dcc_mshells
proc mbots_dcc_mshells {hand idx arg} {
putcmdlog "#$hand# mshells $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X shells [ mbots_encrypt " "]"
if {[meincontrol $idx]} { putidx $idx "[mbots_getshells]" }
}   


bind dcc n mhash mbots_dcc_mhash
proc mbots_dcc_mhash {hand idx arg} {
putcmdlog "#$hand# mhash $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X hash [ mbots_encrypt " "]"
if {[meincontrol $idx]} { rehash }
}   

bind dcc n mjoin mbots_dcc_mjoin
proc mbots_dcc_mjoin {hand idx arg} {
putcmdlog "#$hand# mjoin $arg"

set chan [string trim [lindex [split $arg] 0]]
if {$chan == ""} {
  putidx $idx "usage: .mjoin #channel"
} else {
mbots_log "Adding $chan to mbots"
mbots_putcontrolbots $idx "mbots $idx $hand X join [ mbots_encrypt "$chan"]"
if {[meincontrol $idx]} { mbots_addchan $chan }
utimer 5 "[list mbots_addchantohub $chan]"
}
}   

bind dcc n mpart mbots_dcc_mpart
proc mbots_dcc_mpart {hand idx arg} {
putcmdlog "#$hand# mpart $arg"
set chan [string trim [lindex [split $arg] 0]]
if {$chan == ""} {
  putidx $idx "usage: .mpart #channel"
} else {
mbots_log "Setting $chan to +inactive on mbots"
mbots_putcontrolbots $idx "mbots $idx $hand X part [ mbots_encrypt "$chan"]"
if {[meincontrol $idx]} { mbots_removechan $chan }
}
}   

bind dcc n mdelchan mbots_dcc_mdelchan
proc mbots_dcc_mdelchan {hand idx arg} {
putcmdlog "#$hand# mdelchan $arg"
set chan [string trim [lindex [split $arg] 0]]
if {$chan == ""} {
  putidx $idx "usage: .mdelchan #channel"
} else {
mbots_log "COMPLETELY Removing $chan from mbots"
mbots_putcontrolbots $idx "mbots $idx $hand X delchan [ mbots_encrypt "$chan"]"
if {[meincontrol $idx]} { mbots_delchan $chan }
}
}   


bind dcc n msay mbots_dcc_msay
proc mbots_dcc_msay {hand idx arg} {
putcmdlog "#$hand# msay $arg"
set dest [string trim [slindex $arg 0]]
set msg [string trim [join [lrange [split $arg] 1 end]]]

if {($dest == "") || ($msg == "")} {
  putidx $idx "usage: .msay #channel|nick message"
} else {
mbots_log "Saying to $dest : $msg"
mbots_putcontrolbots $idx "mbots $idx $hand X say [ mbots_encrypt "$dest $msg"]"
if {[meincontrol $idx]} { mbots_say $dest $msg }
}
}

bind dcc n mnotice mbots_dcc_mnotice
proc mbots_dcc_mnotice {hand idx arg} {
putcmdlog "#$hand# mnotice $arg"
set dest [string trim [slindex $arg 0]]
set msg [string trim [join [lrange [split $arg] 1 end]]]

if {($dest == "") || ($msg == "")} {
  putidx $idx "usage: .mnotice #channel|nick message"
} else {
mbots_log "Saying to $dest : $msg"
mbots_putcontrolbots $idx "mbots $idx $hand X notice [ mbots_encrypt "$dest $msg"]"
if {[meincontrol $idx]} { mbots_notice $dest $msg }
}
}

bind dcc n mact mbots_dcc_mact
proc mbots_dcc_mact {hand idx arg} {
putcmdlog "#$hand# mact $arg"
set dest [string trim [slindex $arg 0]]
set msg [string trim [join [lrange [split $arg] 1 end]]]

if {($dest == "") || ($msg == "")} {
  putidx $idx "usage: .mact #channel|nick message"
} else {
mbots_log "Saying to $dest : $msg"
mbots_putcontrolbots $idx "mbots $idx $hand X act [ mbots_encrypt "$dest $msg"]"
if {[meincontrol $idx]} { mbots_act $dest $msg }
}
}

bind dcc n mctcp mbots_dcc_mctcp
proc mbots_dcc_mctcp {hand idx arg} {
putcmdlog "#$hand# mctcp $arg"
set dest [string trim [slindex $arg 0]]
set cmd [string trim [join [lrange [split $arg] 1 1]]]
set params [string trim [join [lrange [split $arg] 2 end]]]

if {($dest == "") || ($cmd == "")} {
  putidx $idx "usage: .mctcp #channel|nick CMD params"
} else {
mbots_log "Doing CTCP $cmd on $dest"
mbots_putcontrolbots $idx "mbots $idx $hand X ctcp [ mbots_encrypt "$dest $cmd $params"]"
if {[meincontrol $idx]} { mbots_ctcp $dest $cmd $params }
}
}



bind dcc n mchanset mbots_dcc_mchanset
proc mbots_dcc_mchanset {hand idx arg} {
putcmdlog "#$hand# mchanset $arg"
set chan [string trim [slindex $arg 0]]
set rest [string trim [join [lrange [split $arg] 1 end]]]

if {($chan == "") || ($rest == "")} {
  putidx $idx "usage: .mchanset #channel settings"
} else {
mbots_log "Doing $rest on $chan on mbots"
mbots_putcontrolbots $idx "mbots $idx $hand X chanset [ mbots_encrypt "$chan $rest"]"
if {[meincontrol $idx]} { mbots_chanset $chan $rest }
}
}

bind dcc n mcontrol mbots_dcc_mcontrol
proc mbots_dcc_mcontrol {hand idx arg} {
putcmdlog "#$hand# mcontrol $arg"
set param1 [string trim [slindex $arg 0]]
global mbots_control mb_botflag botnet-nick
if {$param1 == ""} {
   putidx $idx "usage: .mcontrol bot1 bot2 bot3 (only bot1 bot2 and bot3)"
   putidx $idx "       .mcontrol *              (all mbots)"
   putidx $idx "       .mcontrol -mybots        (my bots)"
   putidx $idx ""

} elseif {$param1 == "-mybots"} {
   setdefaultcontrol $idx
} elseif {$param1 == "*"} {
   set mbots_control($idx) "*"
} else {
   #set arg [string trim [join [lrange [split $arg] 1 end]]]
   set control ""
   # Linked bots
   foreach bot [userlist $mb_botflag] {
     set bot [string tolower $bot]
     if {[islinked $bot]} {
      set ismeant 0
      foreach param [split $arg] {
       set param [string tolower $param]
       if {$param == $bot} { set ismeant 1}
      }
      if {$ismeant == 1} {
       lappend control $bot
      }
     }
   }
   # self
     set mynick [string tolower ${botnet-nick}]
     set ismeant 0
     foreach param [split $arg] {
      set param [string tolower $param]
      if {$param == $mynick} { set ismeant 1}
     }
     if {$ismeant == 1} {
      lappend control ${botnet-nick}
     }
   set mbots_control($idx) [join $control]
}
   putidx $idx "Currently controlling: $mbots_control($idx)"
}

bind dcc n mdump mbots_dcc_mdump
proc mbots_dcc_mdump {hand idx arg} {
putcmdlog "#$hand# mdump $arg"

if {$arg == ""} {
  putidx $idx "usage: .mdump string"
} else {

mbots_putcontrolbots $idx "mbots $idx $hand X dump [ mbots_encrypt "$arg"]"
if {[meincontrol $idx]} { mbots_dump $arg }
}
}


bind dcc n mservers mbots_dcc_mservers
proc mbots_dcc_mservers {hand idx arg} {
putcmdlog "#$hand# mservers $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X server [ mbots_encrypt " "]"
if {[meincontrol $idx]} { putidx $idx "[mbots_getserver]" }
}   

bind dcc n mchans mbots_dcc_mchans
proc mbots_dcc_mchans {hand idx arg} {
putcmdlog "#$hand# mchans $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X chans [ mbots_encrypt " "]"
if {[meincontrol $idx]} { putidx $idx "[mbots_getchans]" }
}  

bind dcc n mnick mbots_dcc_mnick
proc mbots_dcc_mnick {hand idx arg} {
putcmdlog "#$hand# mnick $arg"
mbots_putcontrolbots $idx "mbots $idx $hand X nick [ mbots_encrypt " "]"
if {[meincontrol $idx]} { putidx $idx "[mbots_nick]" }
}  

bind dcc n mupdate mbots_dcc_mupdate
proc mbots_dcc_mupdate {hand idx arg} {
putcmdlog "#$hand# mupdate $arg"
set vrfy [string trim [slindex $arg 0]]

if {($vrfy == "") } {
  putidx $idx "usage: .mupdate -yes"
  putidx $idx ""
  putidx $idx ""
} elseif { $vrfy == "-yes"} {
mbots_log "Trying to update mbots on leafs"
mbots_startupdate $idx $hand
}
}


bind dcc n mchanclose mbots_dcc_mchanclose
proc mbots_dcc_mchanclose {hand idx arg} {
putcmdlog "#$hand# mchanclose $arg"
set chan [string trim [slindex $arg 0]]

if {($chan == "") } {
  putidx $idx "usage: .mchanclose <chan>"
} else {
  if {(![validchan $chan]) || (![botonchan $chan]) || (![botisop $chan]) || (![meincontrol $idx])} {
   mbots_log "Telling mbots to close $chan"
   mbots_putcontrolbots $idx "mbots $idx $hand X close [ mbots_encrypt "$chan"]"   
  } else {
   mbots_log "Trying to close $chan"
   putserv "MODE $chan +ims"
   mbots_putcontrolbots $idx "mbots $idx $hand X masskick [ mbots_encrypt "$chan"]"
   mbots_masskick $chan
  }
}
}




##################################################################################
### Local Commands
##################################################################################

 
bind dcc n ctcp mbots_dcc_ctcp
proc mbots_dcc_ctcp {hand idx arg} {
putcmdlog "#$hand# ctcp $arg"
set dest [string trim [slindex $arg 0]]
set cmd [string trim [join [lrange [split $arg] 1 1]]]
set params [string trim [join [lrange [split $arg] 2 end]]]

if {($dest == "") || ($cmd == "")} {
  putidx $idx "usage: .mctcp #channel|nick CMD params"
} else {
  mbots_ctcp $dest $cmd $params
}
}

bind dcc n addhub mbots_dcc_addhub
proc mbots_dcc_addhub {hand idx arg} {
global botnet-nick
putcmdlog "#$hand# addhub $arg"
set nick [string trim [slindex $arg 0]]
set hostport [string trim [join [lrange [split $arg] 1 1]]]

if {($nick == "") || ($hostport == "")} {
  putidx $idx "usage: .addhub nick host:port"
} else {
  if {${botnet-nick} == $nick} {
   putidx $idx "Crazy?"
  } else {
   if {[validuser $nick]} {
    putidx $idx "Sorry, but $nick already exists"
   } else {
    putidx $idx "Adding $nick with $hostport and trying to link ..."
    addbot $nick $hostport
#    setuser $nick BOTADDR "$hostport"
    chattr $nick +MHof
    botattr $nick +hgp
    link $nick
#    setuser $nick BOTADDR "$hostport"
   }
  } 
}
}

bind dcc n addalthub mbots_dcc_addalthub
proc mbots_dcc_addalthub {hand idx arg} {
global botnet-nick
putcmdlog "#$hand# addalthub $arg"
set nick [string trim [slindex $arg 0]]
set hostport [string trim [join [lrange [split $arg] 1 1]]]

if {($nick == "") || ($hostport == "")} {
  putidx $idx "usage: .addalthub nick host:port"
} else {
  if {${botnet-nick} == $nick} {
   putidx $idx "Crazy?"
  } else {
   if {[validuser $nick]} {
    putidx $idx "Sorry, but $nick already exists"
   } else {
    putidx $idx "Adding $nick with $hostport ..."
    addbot $nick $hostport
    chattr $nick +Mof
    botattr $nick +a
   }
  } 
}
}


bind dcc n addleaf mbots_dcc_addleaf
proc mbots_dcc_addleaf {hand idx arg} {
global botnet-nick
putcmdlog "#$hand# addleaf $arg"
set nick [string trim [slindex $arg 0]]

if {$nick == ""} {
  putidx $idx "usage: .addleaf nick"
} else {
  if {${botnet-nick} == $nick} {
   putidx $idx "Crazy?"
  } else {
   if {[validuser $nick]} {
    putidx $idx "Sorry, but $nick already exists"
   } else {
    putidx $idx "Adding $nick as leaf"
    addbot $nick ""
    chattr $nick +Mof
    botattr $nick +sg
   }
  } 
}
}

bind dcc n opall mbots_dcc_opall
proc mbots_dcc_opall {hand idx arg} {
global botnet-nick
putcmdlog "#$hand# opall"
if {[hand2nick $hand] == ""} { putidx $idx "I don't see you on IRC" ; return 0 }
foreach chan [channels] {
  if {([botisop $chan]) && ([onchan [hand2nick $hand] $chan]) && (![isop [hand2nick $hand] $chan])} {
    pushmode $chan +o [hand2nick $hand]
  }
}
}



bind dcc n inviteall mbots_dcc_inviteall
bind dcc n invall mbots_dcc_inviteall
proc mbots_dcc_inviteall {hand idx arg} {
global botnet-nick
putcmdlog "#$hand# inviteall"
if {[hand2nick $hand] == ""} { putidx $idx "I don't see you on IRC" ; return 0 }
foreach chan [channels] {
  if {([botisop $chan]) && ([onchan [hand2nick $hand] $chan] == 0) && ([isinvonly $chan])} {
    putserv "INVITE [hand2nick $hand] $chan"
  }
}
}

##################################################################################
### Botnet
##################################################################################

bind bot - mbots mbots_handlebotnet
bind bot - mbotsrep mbots_handlebotnetreply

proc incontrol { bot idx } {
 global mbots_control
 set retval 0
 set bot [string tolower $bot]
 if { [info exists mbots_control($idx)] } {
  foreach listbot [split $mbots_control($idx)] {
   set listbot [string tolower $listbot] 
   if { $listbot == $bot } { set retval 1 }
  }
 } else {
  set retval 0
 }
 if {$mbots_control($idx) == "*"} { 
  set retval 1 
 }
 if {$bot == "*"} { 
  set retval 1 
 }
return $retval
}

proc mbots_putallbots { data } {
  global mb_botflag
  foreach bot [userlist $mb_botflag] {
    if {[islinked $bot]} { 
      putbot $bot $data
    }
  }
}

proc mbots_putcontrolbots { idx data } {
  global mb_botflag mbots_control
  if {$mbots_control($idx) == "*"} { 
     mbots_putallbots $data
  } else {
   foreach bot [userlist $mb_botflag] {
     if {([islinked $bot]) && ([incontrol $bot $idx])} { 
       putbot $bot $data
     }
   } 
  }
}

proc meincontrol { idx } {
  global mbots_control botnet-nick
  return [incontrol ${botnet-nick} $idx]
}
                                                    
proc mbots_handlebotnet {frombot command arg} {
global botnick mb_updatestring mb_updateport mb_updatehost mb_updatefilesize mb_updateridx mb_myhub botnet-nick
set idx [lindex [split $arg] 0]
set hand [lindex [split $arg] 1]
set pass [lindex [split $arg] 2]
set subcommand [lindex [split $arg] 3]
set encryptedsubcomdata [lindex [split $arg] 4]
set subcomdata [mbots_decrypt $encryptedsubcomdata]

if { ([validuser $hand]) && ([matchattr $hand n]) } {
  if {[string trim $subcomdata] == ""} {
    mbots_log "$subcommand by $hand@$frombot"
  } else {
    mbots_log "$subcommand by $hand@$frombot ($subcomdata)"
  }
  if {$subcommand == "ping"} {
    putbot $frombot "mbotsrep $idx ping [mbots_encrypt $subcomdata]"
  }
  if {$subcommand == "info"} {
    putbot $frombot "mbotsrep $idx info [mbots_encrypt "[mbots_getinfo]"]"
  }
  if {$subcommand == "shells"} {
    putbot $frombot "mbotsrep $idx shells [mbots_encrypt "[mbots_getshells]"]"
  }
  if {$subcommand == "hash"} {
    rehash
  }
  if {$subcommand == "join"} {
    mbots_addchan $subcomdata
  }
  if {$subcommand == "part"} {
    mbots_removechan $subcomdata
  }
  if {$subcommand == "delchan"} {
    mbots_delchan $subcomdata
  }
  if {$subcommand == "say"} {
    set dest [string trim [slindex $subcomdata 0]]
    set msg [string trim [join [lrange [split $subcomdata] 1 end]]]
    mbots_say $dest $msg
  }
  if {$subcommand == "notice"} {
    set dest [string trim [slindex $subcomdata 0]]
    set msg [string trim [join [lrange [split $subcomdata] 1 end]]]
    mbots_notice $dest $msg
  }
  if {$subcommand == "act"} {
    set dest [string trim [slindex $subcomdata 0]]
    set msg [string trim [join [lrange [split $subcomdata] 1 end]]]
    mbots_act $dest $msg
  }
  if {$subcommand == "ctcp"} {
    set dest [string trim [slindex $subcomdata 0]]
    set cmd [string trim [join [lrange [split $subcomdata] 1 1]]]
    set params [string trim [join [lrange [split $subcomdata] 2 end]]]
    mbots_log "dest: $dest"
    mbots_log "cmd: $cmd"
    mbots_log "params: $params"
    mbots_ctcp $dest $cmd $params
  }
  if {$subcommand == "chanset"} {
    set chan [string trim [slindex $subcomdata 0]]
    set rest [string trim [join [lrange [split $subcomdata] 1 end]]]
    mbots_chanset $chan $rest
  }
  if {$subcommand == "dump"} {
    set arg $subcomdata
    mbots_dump $arg
  }
  if {$subcommand == "server"} {
  putbot $frombot "mbotsrep $idx server [mbots_encrypt "[mbots_getserver]"]"
  }
  if {$subcommand == "chans"} {
  putbot $frombot "mbotsrep $idx chans [mbots_encrypt "[mbots_getchans]"]"
  }
  if {$subcommand == "update"} {
  if {([mbots_conf mb_ishub] == 0) && ($frombot == $mb_myhub)} {
    set mb_updateport [string trim [slindex $subcomdata 0]]
    set mb_updatestring [string trim [slindex $subcomdata 1]]
    set mb_updatefilesize [string trim [slindex $subcomdata 2]]
    set mb_updatehost [lindex [getuser $frombot BOTADDR] 0]
    set mb_updateridx $idx
    utimer [expr 7 + [rand 10] - [rand 5]] "mbots_connectforupdate"
   } else {
    mbots_log "Update Request by non-hub $frombot !"
   }
  }  
  if {$subcommand == "masskick"} {
  mbots_masskick $subcomdata
  }
  if {$subcommand == "nick"} {
  mbots_nick
  }



}
 if {$subcommand == "notes"} {
 } else {
#  mbots_log "$subcommand request by unknown user / user without +n here : $hand@$frombot"
 }

}   

proc mbots_handlebotnetreply {frombot command arg} {
global botnick
set idx [lindex [split $arg] 0]
set subrepl [lindex [split $arg] 1]
set encryptedsubreplydata [lindex [split $arg] 2]
set subreplydata [mbots_decrypt $encryptedsubreplydata]

if {$subrepl == "ping"} {
    putidx $idx "Botnet lag from $frombot : [expr [unixtime] - $subreplydata] sec"
}
if {$subrepl == "info"} {
    putidx $idx "$subreplydata"
}
if {$subrepl == "shells"} {
    putidx $idx "$subreplydata"
}
if {$subrepl == "server"} {
    putidx $idx "$subreplydata"
}
if {$subrepl == "chans"} {
    putidx $idx "$subreplydata"
}
if {$subrepl == "update"} {
    putidx $idx "$frombot : $subreplydata"
}
if {$subrepl == "addhubchan"} {
    mbots_addinactivechan "$subreplydata"
}
if {$subrepl == "addchanstohub"} {
 foreach chan [split $subreplydata] {
  if {![validchan $chan]} {  mbots_addinactivechan $chan }
 }
}
if {$subrepl == "cmdcast"} {
  foreach user [dcclist chat] {
   set idx [lindex $user 0]
   set hand [lindex $user 1]
   if {[matchattr $hand +n]} {
    putidx $idx "$subreplydata"
   }
  }
}

}   

proc mbots_scriptname { } {
  if {[file exists "[pwd]/mbots/mbots.tcl"]} {
    return "[pwd]/mbots/mbots.tcl"
  } else {
    return "[pwd]/scripts/mbots.tcl"
  }
}

proc mbots_startupdate { idx hand } {
  global mb_updatestring mb_updateport
  set bots [bots]
  set udbots ""
  set i 0
  foreach bot $bots { if {[incontrol $bot $idx]} { lappend udbots $bot}}
  set botcount [llength $udbots]
  set mb_updateport [listen [expr [telnetport] + 1] script mbots_updateporthandler]
  utimer 300 "mbots_stopupdate"
  putlog "Listening on $mb_updateport for mupdate for 300 seconds"
  set mb_updatestring [randstring 33]
  set mb_updatefilesize [file size [mbots_scriptname]]
  mbots_putcontrolbots $idx "mbots $idx $hand X update [ mbots_encrypt "$mb_updateport $mb_updatestring $mb_updatefilesize"]"
}

proc mbots_stopupdate { } {
  global mb_updatestring mb_updateport
  set mb_updatestring ""
  listen $mb_updateport off
}

proc mbots_updateporthandler { idx } {
  global mbots_ports
  set mbots_ports($idx) "begin"
  control $idx mbots_portcontrolconnect
}

proc mbots_portcontrolconnect { idx initstring} {
  global mbots_ports mb_key mb_updatestring
  if { ($initstring == $mb_updatestring) && ($mbots_ports($idx) != "end")} {
   set mbotsfilename "[mbots_scriptname]"
   set mbotsfile [open $mbotsfilename r] 
   fconfigure $mbotsfile -translation binary
   while {![eof $mbotsfile]} {
     set string [gets $mbotsfile]
     if {![eof $mbotsfile]} {
       putidx $idx "#$string"
     }
   }
   close $mbotsfile
   utimer 50 "killdcc $idx"
   set mbots_ports($idx) "end"   
  } else {
   #return 1
  }
}

proc mbots_connectforupdate { } {
  global mb_updatestring mb_updateport mb_updatehost mb_key mb_tempfilename temp-path mb_tempfile mb_updateidx
  set mb_tempfilename "${temp-path}/mbots_[randstring 10]_[randstring 10]"
  set mb_tempfile [open $mb_tempfilename w]
  fconfigure $mb_tempfile -translation binary
  set mb_updateidx [ connect $mb_updatehost $mb_updateport]
  control $mb_updateidx mbots_doupdate
  utimer 2 "mbots_sendupdatestring"
  utimer 5 "mbots_sendupdatestring"
  utimer 10 "mbots_sendupdatestring"
  utimer 20 "mbots_sendupdatestring"
  utimer 30 "mbots_sendupdatestring"
  utimer 40 "mbots_sendupdatestring"
}
proc mbots_sendupdatestring { } {
  global mb_updateidx mb_updatestring
  if {[valididx $mb_updateidx]} {
   putidx $mb_updateidx $mb_updatestring
  }
}

proc mbots_doupdate { idx string} {
  global mb_tempfile mb_tempfilename mb_updatefilesize mb_updateridx mb_myhub owner
  if {$string == ""} {
    mbots_log "new mbots.tcl saved to $mb_tempfilename"
    close $mb_tempfile
    set size [file size $mb_tempfilename]
    if {$size == $mb_updatefilesize} {
       mbots_log "Moving update file to existing mbots.tcl script"
       file copy -force $mb_tempfilename [mbots_scriptname]
       file delete $mb_tempfilename
       set errmsg "Recieved and copied mbots.tcl. Rehash needed."
       mbots_sendnote "MBOTS" "$owner" "I recieved a new mbots.tcl"
    } else {
       set errmsg "ALERT! Filesizes when updating didnt match ! Got: $size Expected: $mb_updatefilesize"
    }
    if {[islinked $mb_myhub]} {
      putbot $mb_myhub "mbotsrep $mb_updateridx update [mbots_encrypt "$errmsg"]"  
    } 
    mbots_log $errmsg
  } else {
    puts  $mb_tempfile [join [lrange [split "$string" ""] 1 end] ""]
  }

}


##################################################################################
### getops code here ... by the getops authors and brian99
##################################################################################

set go_bot_unknown 1
set go_bot_unban 1 
set go_cycle 0 
set go_cycle_msg "Please part the channel so the bots can cycle!" 
set ask_all 1 
set offer_key "b" 
set bns "" 
 
proc xmatchattr {hand flags {chan *}} { 
# botversion independend matchattr replacement 
# Kopiert aus: defense.tcl 
# thx to the Author of defense.tcl 
  if {$chan == "*"}  { 
            set ret 1   
            foreach flag [split $flags {}] { 
               set ret [expr $ret & [matchattr $hand $flag]] 
               #check flag by flag coz of the buggy eggdrop matchattr-proc 
            }   
  } else { 
         if {[lsearch [split $flags {}] "|"] > 0} {set op |} else {set op &}             
         set gflags [lindex [split $flags {|&}] 0] 
         if [string match *-* $gflags] {set gflags ""} 
         set lflags [lindex [split $flags {|&}] 1] 
         if {$lflags == ""} { 
                #if a channel is given and only 1 (list of) flag(s), interpret it/them as local ones             
                set lflags $gflags 
                set gflags "" 
         }   
         if [string match *-* $lflags] {set lflags ""} 
         if {($lflags == "") || ($gflags == "")} {set op &} 
         set gfm 1 
         foreach flag [split $gflags {}] { 
             set gfm [expr $gfm & [matchattr $hand $flag]] 
         } 
         set lfm 1 
         foreach flag [split $lflags {}] { 
             set lfm [expr $lfm & [matchattr $hand |$flag $chan]] 
         }    
         set ret [expr $gfm $op $lfm]  
  } 
  return $ret 
}         
 
 
 
proc gain_entrance {what chan} { 
 global botnick botname go_bot_unban go_cycle go_cycle_msg bns ask_all 
 if {[bots] == ""} { 
  putlog "GetOps: No bots to ask for $what for $chan." 
  return 0 
 } 
 if {$what == "op"} { 
  set bns "" 
  if {[hasops $chan]} { 
   set bot [lobots $chan] 
   if {$bot == ""} { 
    set bot [lobots $chan] 
   } 
   if {$bot != ""} { 
    foreach xbot $bot { 
     if { [isop [hand2nick $xbot $chan] $chan] } { 
         #putbot $xbot "gop op $chan $botnick" 
         utimer [expr 1 + [rand 10]] "botnet_getops $xbot $chan"
         lappend bns $xbot 
     } 
    } 
    if {$bns != ""} { 
       putlog "GetOps: Requesting ops from $bns for $chan" 
    } 
   } 
  } { 
   if {$go_cycle} { 
    putserv "NOTICE $chan :$go_cycle_msg" 
   } 
  } 
 } else { 
   set askbots ""
   foreach opbot [bots] { 
   if { ${ask_all} == "1" } { 
     if {[matchattr $opbot o|o $chan]} {  
            putbot $opbot "gop $what $chan $botnick" 
            lappend askbots $opbot
          } 
    } else {  
     if {[matchattr $opbot |o $chan]} { 
            putbot $opbot "gop $what $chan $botnick" 
            lappend askbots $opbot
         } 
   } 
  } 
  putlog "GetOps: Requesting $what from [join $askbots ", "] for $chan."
 } 
} 
 
proc hasops {chan} { 
 foreach user [chanlist $chan] { 
  if {[isop $user $chan]} { 
   return 1 
  } 
 } 
 return 0 
} 
 
proc getbot {chan} { 
 global bns 
 foreach bn [bots] { 
  if {[lsearch $bns $bn] < 0} { 
   if {([matchattr $bn o]) || ([matchattr $bn |o $chan])} { 
    if {([onchan [hand2nick $bn $chan] $chan]) && ([isop [hand2nick $bn $chan] $chan])} { 
     return $bn 
     break 
    } 
   } 
  } 
 } 
} 
 
proc botnet_getops {bot chan} {
  global botnick
  if {![botisop $chan]} {
   putlog "GetOps: Requesting delayed op from $bot on $chan"
   putbot $bot "gop op $chan $botnick" 
  }
}



proc botnet_request {bot com args} { 
 global botnick go_bot_unban go_bot_unknown offer_key ask_all 
 set args [lindex $args 0] 
 set subcom [lindex $args 0] 
 set chan [string tolower [lindex $args 1]] 
 set nick [lindex $args 2] 
 if {![matchattr $bot b]} { 
  if {$go_bot_unknown == 1} { 
   putlog "GetOps: Request ($subcom) from $bot - unknown bot (IGNORED)" 
  } 
  return 0 
 } 
 if {$subcom == "offerop"} { 
   if { ${ask_all} == 1 } { 
     set askflags "o|o" 
    } else { 
     set askflags "|o" 
   } 
   if { ([xmatchattr $bot ${offer_key}]) && ([xmatchattr $bot $askflags $chan])} { 
    #putbot $bot "gop op $chan $botnick" 
    utimer [expr 1 + [rand 20]] "botnet_getops $bot $chan"
    #putlog "GetOps: OFFER-OP von $bot in Channel $chan" 
    return 0 
   } else { 
    putlog "GetOps: OFFER-OP von Fremdbot $bot in channel $chan ...." 
    return 0 
   } 
  } 
 if {$subcom != "takekey"} { 
  if {![validchan $chan]} { 
#   putbot $bot "gop_resp I don't monitor $chan." 
   return 0 
  } 
  if {![onchan $botnick $chan]} { 
   putbot $bot "gop_resp I am not on $chan." 
   return 0 
  } 
 } 
 switch -exact $subcom { 
  "op" { 
   if {![onchan $nick $chan]} { 
    putbot $bot "gop_resp You are not on $chan for me." 
    return 1 
   } 
   set bothand [finduser $nick![getchanhost $nick $chan]] 
   if {$bothand == "*"} { 
    putlog "GetOps: $bot requested ops for $chan. Hostmask not recognized: $nick![getchanhost $nick $chan]." 
    putbot $bot "gop_resp I don't recognize you by the hostmask $nick![getchanhost $nick $chan])" 
    return 1 
   } 
   if {[string tolower $bothand] == [string tolower $nick]} { 
    putlog "GetOps: $bot requested ops for $chan." 
   } { 
    putlog "GetOps: $bot requested ops as $nick for $chan." 
   } 
   if {[iso $nick $chan] && [matchattr $bothand b]} { 
    if {[botisop $chan]} { 
     if {![isop $nick $chan]} { 
      # utimer geändert von [rand 10] 
#      utimer [rand 3] "chkop $chan $nick" 
       chkop $chan $nick 
     } 
    } { 
     putbot $bot "gop_resp I am not oped on $chan." 
    } 
   } { 
    putbot $bot "gop_resp You aren't +o in my userlist for $chan." 
   } 
   return 1 
  } 
  "unban" { 
   putlog "GetOps: $bot requested that I unban him on $chan." 
   putserv "INVITE $nick $chan" 
   return 1 
  } 
  "invite" { 
   putlog "GetOps: $bot asked for an invite to $chan." 
   putserv "INVITE $nick $chan" 
   return 1 
  } 
  "limit" { 
   putlog "GetOps: $bot asked for a limit raise on $chan." 
   #pushmode $chan +l [expr [llength [chanlist $chan]] + 1] 
   putserv "INVITE $nick $chan"
   return 1 
  } 
  "key" { 
   putlog "GetOps: $bot requested the key on $chan." 
   if {[string match *k* [lindex [getchanmode $chan] 0]]} { 
    putbot $bot "gop takekey $chan [lindex [getchanmode $chan] 1]" 
   } { 
    putbot $bot "gop_resp There isn't a key on $chan." 
   } 
   return 1 
  } 
  "takekey" { 
   putlog "GetOps: $bot gave me the key to $chan. ($nick)" 
   foreach channel [string tolower [channels]] { 
    if {$chan == $channel} { 
     putserv "JOIN $channel $nick" 
     return 1 
    } 
   } 
  } 
  default { 
   putlog "GetOps: ALERT! $bot sent fake 'gop' message. ($subcom)" 
  } 
 } 
} 
 
proc chkop {chan nick} { 
 if {[isop $nick $chan]} { 
  putlog "GetOps: $nick is already opped on $chan, ignoring." 
  return 0 
 } 
 pushmode $chan +o $nick 
 return 1 
} 
 
proc gop_resp {bot com msg} { 
 putlog "GetOps: MSG from $bot: $msg" 
 return 1 
} 
 
proc lbots {} { 
 set unf "" 
 foreach users [userlist b] { 
  foreach bs [bots] { 
   if {$users == $bs} { 
    lappend unf $users 
   } 
  } 
 } 
 return $unf 
} 
 
# Returns list of bots in the botnet and +o in my userfile on that channel 
 
proc lobots {chan1} { 
 global ask_all 
 set bots "" 
 foreach bot [bots] { 
 if { ${ask_all} == "1" } { 
   if {[matchattr $bot o|o $chan1]} { lappend bots $bot } 
  } else {  
   if {[matchattr $bot |o $chan1]} { lappend bots $bot } 
  } 
 } 
 return $bots 
} 
 
proc iso {nick chan1} { 
 return [matchattr [nick2hand $nick $chan1] o|o $chan1] 
} 
 
proc do_channels {} { 
 global go_chanset 
 foreach a [string tolower [channels]] { 
  if {([lsearch -regexp [channel info $a] gain_entrance] < 0)} { 
   channel set $a need-op "gain_entrance op $a" 
   channel set $a need-key "gain_entrance key $a" 
   channel set $a need-invite "gain_entrance invite $a" 
   channel set $a need-unban "gain_entrance unban $a" 
   channel set $a need-limit "gain_entrance limit $a" 
   set go_chanset($a) 1 
  } 
 } 
 if {![string match "*do_channels*" [timers]]} { timer 5 do_channels } 
} 
 
if {![string match "*do_channels*" [utimers]]} { 
 # Set things up one second after starting (dynamic things already loaded) 
 utimer 1 do_channels 
} 
 
bind bot - gop botnet_request 
bind bot - gop_resp gop_resp 
 
# Ask for ops when joining a channel 
bind join - * gop_join 
 

proc requestop {chan} { 
 utimer 5 "xrequestop $chan" 
} 
 
proc lastrequestop {chan} { 
 xrequestop $chan 1
} 
 
proc xrequestop {chan anzahl} { 
 global botnick 
 set chan [string tolower $chan]
 set i 0
 foreach thisbot [randlist [lobots $chan]] { 
  if { [isop [hand2nick $thisbot $chan] $chan]} { 
     incr i
     if {$i < 10} {
      utimer [expr 1 + $i] "botnet_getops $bot $chan" 
      lappend askedbot $thisbot 
     }
   }  
 } 
 return 0 
} 
 
 
proc sortbots {botlist} { 
 regsub -all " " $botlist ", " botlist 
 return $botlist 
} 
 
proc joinop {hand chan} { 
  global offer_key ask_all 
  if { ([botisop $chan]) && ([xmatchattr $hand ${offer_key}]) && ([islinked $hand])} { 
    if { ${ask_all} == "0" } { 
      if {[matchattr $hand |o $chan]} {return 1} 
    } else { 
      if {[matchattr $hand o|o $chan]} {return 1} 
    } 
  } 
  return 0 
} 
 
 
 
proc gop_join {nick uhost hand chan} { 
 global botnick 
 # Check if it was me joining 
 if {$nick != $botnick} { 
   if {[joinop $hand $chan]} { 
    putbot $hand "gop offerop $chan" 
#    putlog "GetOps: OFFER-OP fuer $hand auf $chan" 
    return 0 
   } else {      
    return 0  
  } 
 }  
 # Adjust channel settings, if needed (e.g when a dynamic channel was added) 
 do_channels 
 set chan [string tolower $chan] 
 # Wait 5 sec, because IRC-lag > Botnet-Lag 
 # geändert: 2 sekunden; zurück auf 5 sek :( 
 set dummyanzahl 1 
# utimer 6 "requestop $chan" 
 utimer 3 "xrequestop $chan $dummyanzahl" 
 return 0 
} 
 
bind mode * * proc_fastop 

proc make_mirkop { chan } {
     putlog "GetOps: Doing a mirk style op on $chan !"
     set botstoop ""
     foreach user [chanlist $chan] {
      if {([matchattr [nick2hand $user] b]) && ([matchattr [nick2hand $user] o|o $chan]) && (![isop $user $chan])} {
       #pushmode $chan +o $user
       lappend botstoop $user
      }
      foreach user [randlist $botstoop] {
        pushmode $chan +o $user
      }
     }
}

proc make_superbitch { nick victim chan } {

   global mb_superbitchkickglobalops
     if {([ischansettingset $chan "+superbitch"]) && ([botisop $chan])} {
          if {(![xmatchattr [nick2hand $nick] +n|+n $chan]) && (![xmatchattr [nick2hand $nick] o&f&b]) && ([onchan $nick $chan]) && (![xmatchattr [nick2hand $victim] o&f&b]) && (![isbotnick $victim]) && (![isbotnick $nick]) && (![xmatchattr [nick2hand $nick] +E|+E $chan])} {
           if {$mb_superbitchkickglobalops == 1} {
              putkick $chan $nick,$victim "Bitch-X BaBy!"
           } else {
             if {[xmatchattr [nick2hand $nick] o]} {
              putkick $chan $victim "Bitch-X BaBy!"
             } else {
              putkick $chan $nick,$victim "Bitch-X BaBy!"
             }
           }
          }
     }
}
 
proc proc_fastop {nick uhost hand chan mc victim } { 
  global botnick 
  set modebot "" 
  if { $mc != "+o"} {return 0} 

  if { $victim == $botnick } {
    set oppedbots ""
    foreach user [chanlist $chan o] {
      if {([matchattr [nick2hand $user] b]) && ([isop $user $chan])} {
       lappend oppedbots $user
      }
    } 
    if {[llength $oppedbots] < 3} {
     make_mirkop $chan
    }
  }
  if { $victim != $botnick } { 
     make_superbitch $nick $victim $chan
  }
} 
 
 
 
 
set getops_loaded 1 
set getops_brian_version "0.94a" 

mbots_log "Getops loaded"

##################################################################################
### Flood Detection by sentinel.tcl
### forgive me my shameless rip ;P
##################################################################################

set sl_bcflood 6:[expr 30 + [rand 30]]
set sl_bmflood 7:[expr 20 + [rand 20]]
set sl_ccflood 6:[expr 20 + [rand 20]]
set sl_avflood 7:[expr 20 + [rand 20]]
set sl_txflood 90:[expr 30 + [rand 30]]
set sl_boflood 5:[expr 20 + [rand 20]]
set sl_jflood 7:[expr 20 + [rand 20]]
set sl_nkflood 7:[expr 20 + [rand 20]]
set sl_ban [expr 1440 + [rand 40]] 
set sl_boban [expr 1440 + [rand 40]]
set sl_globalban 0
set sl_banmax 100
set sl_igtime 240
set sl_ilocktime [expr 120 + [rand 50]] 
set sl_mlocktime [expr 60 + [rand 25]] 
set sl_shortlock 0
set sl_bfmaxbans 19
set sl_note "$owner"
set sl_cfnotice ""
set sl_bfnotice ""
set sl_lockcmds 2
set sl_lockflags "o"
set sl_bxsimul 0


if {$numversion < 1032400} {
  if {[info commands onchan] != ""} {
    proc botonchan {chan} {
      global botnick
      if {![validchan $chan]} {
        error "illegal channel: $chan"
      } elseif {![onchan $botnick $chan]} {
        return 0
      }
      return 1
    }
  }
  proc putquick {text} {
    putserv $text
  }
}

proc sl_ctcp {nick uhost hand dest key arg} {
  global botnet-nick botnick realname sl_ban sl_bflooded sl_bcflood sl_bcqueue sl_bxjointime sl_bxmachine sl_bxonestack sl_bxsimul sl_bxsystem sl_bxversion sl_bxwhoami sl_ccbanhost sl_ccbannick sl_ccflood sl_ccqueue sl_flooded sl_locked sl_note
  set chan [string tolower $dest]
  if {(([lsearch -exact $sl_ccflood 0] == -1) && ([validchan $chan]) && (![isop $nick $chan]))} {
    if {$nick == $botnick} {return 0}
    if {(($sl_ban) && (!$sl_locked($chan)) && (![matchattr $hand f|f $chan]))} {
      lappend sl_ccbannick($chan) $nick ; lappend sl_ccbanhost($chan) *!*[string tolower [string range $uhost [string first @ $uhost] end]]
      utimer [lindex $sl_ccflood 1] [split "sl_ccbanqueue $chan"]
    }
    if {$sl_flooded($chan)} {return 1}
    incr sl_ccqueue($chan)
    utimer [lindex $sl_ccflood 1] [split "sl_ccqueuereset $chan"]
    if {$sl_ccqueue($chan) >= [lindex $sl_ccflood 0]} {
      sl_lock $chan "CTCP flood" ${botnet-nick} ; return 1
    }
    if {$sl_bflooded} {return 1}
  } elseif {(([lindex $sl_bcflood 0]) && ($dest == $botnick))} {
    if {$sl_bflooded} {
      sl_ignore $uhost $hand "CTCP flooder" ; return 1
    }
    incr sl_bcqueue
    utimer [lindex $sl_bcflood 1] "incr sl_bcqueue -1"
    if {$sl_bcqueue >= [lindex $sl_bcflood 0]} {
      putlog "sentinel: CTCP flood detected on me! Stopped answering CTCPs temporarily."
      set sl_bflooded 1
      utimer [lindex $sl_bcflood 1] "set sl_bflooded 0"
      if {[info commands sendnote] != ""} {
        foreach recipient $sl_note {
          if {[validuser $recipient]} {
            mbots_sendnote SENTINEL $recipient "Bot was CTCP flooded."
          }
        }
      }
      return 1
    }
  }

  return 0
}

proc sl_bmflood {nick uhost hand text} {
  global sl_bmflood sl_bflooded sl_bmqueue sl_note
  if {(([matchattr $hand b]) && ([string tolower [lindex [split $text] 0]] == "go"))} {return 0}
  if {$sl_bflooded} {
    sl_ignore $uhost $hand "MSG flooder" ; return 0
  }
  incr sl_bmqueue
  utimer [lindex $sl_bmflood 1] "incr sl_bmqueue -1"
  if {$sl_bmqueue >= [lindex $sl_bmflood 0]} {
    putlog "sentinel: MSG flood detected on me! Stopped answering MSGs temporarily."
    set sl_bflooded 1
    utimer [lindex $sl_bmflood 1] "set sl_bflooded 0"
    if {[info commands sendnote] != ""} {
      foreach recipient $sl_note {
        if {[validuser $recipient]} {
          mbots_sendnote SENTINEL $recipient "Bot was MSG flooded."
        }
      }
    }
  }
  return 0
}

proc sl_avflood {from keyword arg} {
  global botnet-nick botnick sl_ban sl_avbanhost sl_avbannick sl_avflood sl_avqueue sl_flooded sl_locked sl_txflood sl_txqueue
  set arg [split $arg]
  set chan [string tolower [lindex $arg 0]]
  if {![validchan $chan]} {return 0}
  set nick [lindex [split $from !] 0]
  if {(($nick == $botnick) || ($nick == "") || ([string match *.* $nick]))} {return 0}
  if {((![onchan $nick $chan]) || ([isop $nick $chan]))} {return 0}
  if {((!$sl_flooded($chan)) && ([lsearch -exact $sl_txflood 0] == -1))} {
    incr sl_txqueue($chan)
    if {$sl_txqueue($chan) >= [lindex $sl_txflood 0]} {
      sl_lock $chan "TEXT flood" ${botnet-nick}
    }
  }
  set text [join [lrange $arg 1 end]]
  if {(([sl_checkaval $text]) && ([lsearch -exact $sl_avflood 0] == -1))} {
    set uhost [string trimleft [getchanhost $nick $chan] "~+-^="]
    set hand [nick2hand $nick $chan]
    if {(($sl_ban) && (!$sl_locked($chan)) && ($nick != $botnick) && (![matchattr $hand f|f $chan]))} {
      lappend sl_avbannick($chan) $nick ; lappend sl_avbanhost($chan) *!*[string tolower [string range $uhost [string first @ $uhost] end]]
      utimer [lindex $sl_avflood 1] [split "sl_avbanqueue $chan"]
    }
    if {$sl_flooded($chan)} {return 0}
    incr sl_avqueue($chan)
    utimer [lindex $sl_avflood 1] [split "sl_avqueuereset $chan"]
    if {$sl_avqueue($chan) >= [lindex $sl_avflood 0]} {
      sl_lock $chan "AVALANCHE flood" ${botnet-nick}
    }
  }
  return 0
}

proc sl_checkaval {text} {
  if {[expr [regsub -all -- "\007" $text "" temp] + [regsub -all -- "\001" $temp "" temp]] >= 3} {return 1}
  return 0
}

proc sl_nkflood {nick uhost hand chan newnick} {
  global botnet-nick botnick sl_ban sl_banmax sl_flooded sl_globalban sl_locked sl_nickkick sl_nkbanhost sl_nkflood sl_nkflooding sl_nkqueue
  set chan [string tolower $chan]
  if {[isop $newnick $chan]} {return 0}
  if {(($sl_ban) && (!$sl_locked($chan)) && ($nick != $botnick) && (![matchattr $hand f|f $chan]))} {
    lappend sl_nkbanhost($chan) *!*[string tolower [string range $uhost [string first @ $uhost] end]]
    utimer [lindex $sl_nkflood 1] [split "sl_nkbanqueue $chan"]
  }
  if {((!$sl_nickkick) && ($sl_flooded($chan)) && ($sl_locked($chan)))} {
    putserv "KICK $chan $newnick :NICK flooder"
    set sl_nickkick 1 ; set sl_nkflooding($chan) [unixtime]
    if {$sl_ban} {
      set bhost *!*[string tolower [string range $uhost [string first @ $uhost] end]]
      if {$sl_globalban} {
        if {(([llength [banlist]] < $sl_banmax) && (![isban $bhost]))} {
          newban $bhost sentinel "NICK flooder" $sl_ban
        }
      } else {
        if {(([llength [banlist $chan]] < $sl_banmax) && (![isban $bhost $chan]))} {
          newchanban $chan $bhost sentinel "NICK flooder" $sl_ban
        }
      }
    }
    utimer [expr [rand 2] + 3] "set sl_nickkick 0"
    return 0
  }
  if {$sl_flooded($chan)} {return 0}
  incr sl_nkqueue($chan)
  utimer [lindex $sl_nkflood 1] [split "sl_nkqueuereset $chan"]
  if {$sl_nkqueue($chan) >= [lindex $sl_nkflood 0]} {
    sl_lock $chan "NICK flood" ${botnet-nick}
  }
  return 0
}

proc sl_jflood {nick uhost hand chan} {
  global botnet-nick botnick sl_ban sl_banmax sl_boban sl_bobanhost sl_bobannick sl_boflood sl_boqueue sl_flooded sl_globalban sl_jbanhost sl_jbannick sl_jflood sl_jqueue sl_locked sl_pqueue
  if {$nick == $botnick} {
    sl_setarray $chan
  } else {
    set ihost *!*[string tolower [string range $uhost [string first @ $uhost] end]]
    if {[isignore $ihost]} {
      killignore $ihost
    }
    set chan [string tolower $chan]
    if {(([lsearch -exact $sl_boflood 0] == -1) && ([sl_checkbogus [lindex [split $uhost @] 0]]))} {
      if {((!$sl_locked($chan)) && (![matchattr $hand f|f $chan]))} {
        set bhost *!*[string tolower [string range $uhost [string first @ $uhost] end]]
        if {(($sl_boban) && ([botisop $chan]) && (!$sl_flooded($chan)))} {
          putserv "KICK $chan $nick :BOGUS username"
          if {$sl_globalban} {
            if {(([llength [banlist]] < $sl_banmax) && (![isban $bhost]))} {
              newban $bhost sentinel "BOGUS username" $sl_boban
            }
          } else {
            if {(([llength [banlist $chan]] < $sl_banmax) && (![isban $bhost $chan]))} {
              newchanban $chan $bhost sentinel "BOGUS username" $sl_boban
            }
          }
        }
        if {$sl_ban} {
          lappend sl_bobannick($chan) $nick ; lappend sl_bobanhost($chan) $bhost
          utimer [lindex $sl_boflood 1] [split "sl_bobanqueue $chan"]
        }
      }
      if {!$sl_flooded($chan)} {
        incr sl_boqueue($chan)
        utimer [lindex $sl_boflood 1] [split "sl_boqueuereset $chan"]
        if {$sl_boqueue($chan) >= [lindex $sl_boflood 0]} {
          sl_lock $chan "BOGUS joins" ${botnet-nick}
        }
      }
    }
    if {[lsearch -exact $sl_jflood 0] == -1} {
      if {(($sl_ban) && (!$sl_locked($chan)) && (![matchattr $hand f|f $chan]))} {
        lappend sl_jbannick($chan) $nick ; lappend sl_jbanhost($chan) *!*[string tolower [string range $uhost [string first @ $uhost] end]]
        utimer [lindex $sl_jflood 1] [split "sl_jbanqueue $chan"]
      }
      if {$sl_flooded($chan)} {return 0}
      incr sl_jqueue($chan)
      utimer [lindex $sl_jflood 1] [split "sl_jqueuereset $chan"]
      if {(($sl_jqueue($chan) >= [lindex $sl_jflood 0]) && ($sl_pqueue($chan) >= [lindex $sl_jflood 0]))} {
        sl_lock $chan "JOIN-PART flood" ${botnet-nick}
      }
    }
  }
  return 0
}

proc sl_checkbogus {ident} {
  if {[regsub -all -- "\[^\041-\176\]" $ident "" temp] >= 1} {return 1}
  return 0
}

proc sl_pflood {nick uhost hand chan {msg ""}} {
  global botnick sl_ban sl_flooded sl_jflood sl_locked sl_pbanhost sl_pbannick sl_pqueue
  if {[lsearch -exact $sl_jflood 0] != -1} {return 0}
  if {$nick == $botnick} {return 0}
  set chan [string tolower $chan]
  if {(($sl_ban) && (!$sl_locked($chan)) && (![matchattr $hand f|f $chan]))} {
    lappend sl_pbannick($chan) $nick ; lappend sl_pbanhost($chan) *!*[string tolower [string range $uhost [string first @ $uhost] end]]
    utimer [lindex $sl_jflood 1] [split "sl_pbanqueue $chan"]
  }
  if {$sl_flooded($chan)} {return 0}
  incr sl_pqueue($chan)
  utimer [lindex $sl_jflood 1] [split "sl_pqueuereset $chan"]
  return 0
}

proc sl_pfloodk {nick uhost hand chan kicked reason} {
  global botnick sl_flooded sl_jflood sl_pqueue
  if {[lsearch -exact $sl_jflood 0] != -1} {return 0}
  if {$kicked == $botnick} {return 0}
  set chan [string tolower $chan]
  if {$sl_flooded($chan)} {return 0}
  incr sl_pqueue($chan)
  utimer [lindex $sl_jflood 1] [split "sl_pqueuereset $chan"]
  return 0
}

proc sl_lock {chan flood detected} {
  global botnet-nick sl_bflooded sl_cfnotice sl_flooded sl_ilocktime sl_mlocktime sl_note
  if {$detected == ${botnet-nick}} {
    set sl_flooded($chan) 1 ; set sl_bflooded 1
    if {[botisop $chan]} {
      putquick "MODE $chan +mi"
      sl_killutimer "sl_unlock $chan *"
      sl_killutimer "set sl_bflooded 0"
      if {$sl_mlocktime} {
        utimer $sl_mlocktime [split "sl_unlock $chan m"]
      }
      if {$sl_ilocktime} {
        utimer $sl_ilocktime [split "sl_unlock $chan i"]
      }
      utimer 120 "set sl_bflooded 0"
      putlog "sentinel: $flood detected on $chan! Channel locked temporarily."
      if {$sl_cfnotice != ""} {
        puthelp "NOTICE $chan :$sl_cfnotice"
      }
    } else {
      putlog "sentinel: $flood detected on $chan! Cannot lock channel because I'm not opped."
      utimer 120 "set sl_bflooded 0"
    }
  } else {
    putlog "sentinel: $flood detected by $detected on $chan!"
  }
  if {[info commands sendnote] != ""} {
    foreach recipient $sl_note {
      if {[validuser $recipient]} {
        if {$detected == ${botnet-nick}} {
          mbots_sendnote SENTINEL $recipient "$flood detected on $chan."
        } else {
          mbots_sendnote SENTINEL $recipient "$flood detected by $detected on $chan."
        }
      }
    }
  }
  return 0
}

proc sl_unlock {chan umode} {
  global sl_bflooded sl_bfmaxbans sl_flooded sl_ilocktime sl_mlocktime sl_nkflooding
  if {[expr [unixtime] - $sl_nkflooding($chan)] < 12} {
    putlog "sentinel: nick flooding still in progress on $chan - not removing +mi yet.."
    set sl_flooded($chan) 1 ; set sl_bflooded 1
    sl_killutimer "sl_unlock $chan *"
    sl_killutimer "set sl_bflooded 0"
    utimer $sl_mlocktime [split "sl_unlock $chan m"] ; utimer $sl_ilocktime [split "sl_unlock $chan i"]
    utimer 120 "set sl_bflooded 0"
  } else {
    set sl_flooded($chan) 0
    if {![botisop $chan]} {return 0}
    if {$umode == "mi"} {
      putlog "sentinel: flood was small, performing early unlock.."
    }
    if {(([string match *i* $umode]) && ([string match *i* [lindex [split [getchanmode $chan]] 0]]))} {
      if {(($sl_bfmaxbans) && ([llength [chanbans $chan]] >= $sl_bfmaxbans))} {
        putlog "sentinel: not removing +i on $chan due to full ban list."
      } else {
        pushmode $chan -i
        putlog "sentinel: removed +i on $chan"
      }
    }
    if {(([string match *m* $umode]) && ([string match *m* [lindex [split [getchanmode $chan]] 0]]))} {
      pushmode $chan -m
      putlog "sentinel: removed +m on $chan"
    }
  }
  return 0
}

proc sl_mode {nick uhost hand chan mode victim} {
  global botnick sl_ban sl_bfmaxbans sl_bfnotice sl_bfull sl_flooded sl_locked sl_note sl_unlocked
  set chan [string tolower $chan]
  if {(($mode == "+b") && ($sl_bfmaxbans) && (!$sl_bfull($chan)) && (![string match *i* [lindex [split [getchanmode $chan]] 0]]) && ([botisop $chan]) && ([llength [chanbans $chan]] >= $sl_bfmaxbans))} {
    putserv "MODE $chan +i"
    set sl_bfull($chan) 1
    utimer 5 [split "set sl_bfull($chan) 0"]
    putlog "sentinel: locked $chan due to full ban list!"
    if {$sl_bfnotice != ""} {
      puthelp "NOTICE $chan :$sl_bfnotice"
    }
    if {[info commands sendnote] != ""} {
      foreach recipient $sl_note {
        if {[validuser $recipient]} {
          mbots_sendnote SENTINEL $recipient "Locked $chan due to full ban list."
        }
      }
    }
  } elseif {(($mode == "+i") && ($sl_flooded($chan)))} {
    set sl_locked($chan) 1
    if {$sl_ban} {
      sl_killutimer "sl_*banqueue $chan"
      utimer 7 [split "sl_dokicks $chan"] ; utimer 16 [split "sl_setbans $chan"]
    }
  } elseif {(($mode == "-i") || ($mode == "-m"))} {
    set sl_locked($chan) 0
    set sl_unlocked($chan) [unixtime]
    if {$sl_flooded($chan)} {
      set sl_flooded($chan) 0
      if {$mode == "-i"} {
        sl_killutimer "sl_unlock $chan i"
      } else {
        sl_killutimer "sl_unlock $chan m"
      }
      sl_killutimer "sl_unlock $chan mi"
      if {$nick != $botnick} {
        putlog "sentinel: $chan unlocked by $nick"
      }
    }
  }
  return 0
}

proc sl_dokicks {chan} {
  global sl_avbannick sl_bobannick sl_ccbannick sl_kflooders sl_jbannick sl_pbannick
  if {((![botonchan $chan]) || (![botisop $chan]))} {return 0}
  set sl_kflooders 0
  sl_kick $chan $sl_ccbannick($chan) "CTCP flooder" ; set sl_ccbannick($chan) ""
  sl_kick $chan $sl_avbannick($chan) "AVALANCHE flooder" ; set sl_avbannick($chan) ""
  sl_kick $chan $sl_bobannick($chan) "BOGUS username" ; set sl_bobannick($chan) ""
  set jklist $sl_jbannick($chan) ; set pklist $sl_pbannick($chan)
  if {(($jklist != "") && ($pklist != ""))} {
    set klist ""
    foreach nick $jklist {
      if {[lsearch -exact $pklist $nick] != -1} {
        lappend klist $nick
      }
    }
    sl_kick $chan $klist "JOIN-PART flooder"
  }
  set sl_jbannick($chan) "" ; set sl_pbannick($chan) ""
  return 0
}

proc sl_kick {chan klist reason} {
  global sl_kflooders sl_kicks
  if {$klist != ""} {
    set kicklist ""
    foreach nick $klist {
      if {[lsearch -exact $kicklist $nick] == -1} {
        lappend kicklist $nick
      }
    }
    unset nick
    incr sl_kflooders [llength $kicklist]
    foreach nick $kicklist {
      if {(([onchan $nick $chan]) && (![onchansplit $nick $chan]))} {
        lappend ksend $nick
        if {[llength $ksend] >= $sl_kicks} {
          putserv "KICK $chan [join $ksend ,] :$reason"
          unset ksend
        }
      }
    }
    if {[info exists ksend]} {
      putserv "KICK $chan [join $ksend ,] :$reason"
    }
  }
  return 0
}

proc sl_setbans {chan} {
  global sl_avbanhost sl_bflooders sl_bobanhost sl_ccbanhost sl_kflooders sl_jbanhost sl_nkbanhost sl_pbanhost sl_shortlock sl_unlocked
  if {![botonchan $chan]} {return 0}
  set sl_bflooders 0
  sl_ban $chan $sl_ccbanhost($chan) "CTCP flooder" ; set sl_ccbanhost($chan) ""
  sl_ban $chan $sl_avbanhost($chan) "AVALANCHE flooder" ; set sl_avbanhost($chan) ""
  sl_ban $chan $sl_nkbanhost($chan) "NICK flooder" ; set sl_nkbanhost($chan) ""
  sl_ban $chan $sl_bobanhost($chan) "BOGUS username" ; set sl_bobanhost($chan) ""
  set jblist $sl_jbanhost($chan) ; set pblist $sl_pbanhost($chan)
  if {(($jblist != "") && ($pblist != ""))} {
    set blist ""
    foreach bhost $jblist {
      if {[lsearch -exact $pblist $bhost] != -1} {
        lappend blist $bhost
      }
    }
    sl_ban $chan $blist "JOIN-PART flooder"
  }
  set sl_jbanhost($chan) "" ; set sl_pbanhost($chan) ""
  if {(($sl_shortlock) && ($sl_kflooders <= 2) && ($sl_bflooders <= 2) && ([expr [unixtime] - $sl_unlocked($chan)] > 120))} {
    sl_killutimer "sl_unlock $chan *"
    utimer 10 [split "sl_unlock $chan mi"]
  }
  return 0
}

proc sl_ban {chan blist reason} {
  global sl_ban sl_banmax sl_bflooders sl_globalban
  if {$blist != ""} {
    set banlist ""
    foreach bhost $blist {
      if {[lsearch -exact $banlist $bhost] == -1} {
        lappend banlist $bhost
      }
    }
    incr sl_bflooders [llength $banlist]
    if {$sl_globalban} {
      foreach bhost $banlist {
        if {(([llength [banlist]] >= $sl_banmax) || ([isban $bhost]) || ([ispermban $bhost]))} {continue}
        newban $bhost sentinel $reason $sl_ban
        putlog "sentinel: banned $bhost ($reason)"
        sl_ignore $bhost * $reason
      }
    } else {
      foreach bhost $banlist {
        if {(([llength [banlist $chan]] >= $sl_banmax) || ([isban $bhost $chan]) || ([ispermban $bhost $chan]))} {continue}
        newchanban $chan $bhost sentinel $reason $sl_ban
        putlog "sentinel: banned $bhost on $chan ($reason)"
        sl_ignore $bhost * $reason
      }
    }
  }
  return 0
}

proc sl_ignore {uhost hand flood} {
  global sl_igtime
  if {$hand != "*"} {
    foreach chan [channels] {
      if {[matchattr $hand f|f $chan]} {return 0}
    }
  }
  set ihost *!*[string tolower [string range $uhost [string first @ $uhost] end]]
  if {[isignore $ihost]} {return 0}
  newignore $ihost sentinel $flood $sl_igtime
  putlog "sentinel: added $ihost to ignore list ($flood)"
  return 0
}

proc sl_ccqueuereset {chan} {
  global sl_ccqueue
  incr sl_ccqueue($chan) -1
  return 0
}

proc sl_bcqueuereset {} {
  global sl_bcqueue
  incr sl_bcqueue -1
  return 0
}

proc sl_bmqueuereset {} {
  global sl_bmqueue
  incr sl_bmqueue -1
  return 0
}

proc sl_avqueuereset {chan} {
  global sl_avqueue
  incr sl_avqueue($chan) -1
  return 0
}

proc sl_txqueuereset {} {
  global sl_txqueue sl_txflood
  foreach chan [string tolower [channels]] {
    if {[info exists sl_txqueue($chan)]} {
      set sl_txqueue($chan) 0
    }
  }
  utimer [lindex $sl_txflood 1] sl_txqueuereset
  return 0
}

proc sl_nkqueuereset {chan} {
  global sl_nkqueue
  incr sl_nkqueue($chan) -1
  return 0
}

proc sl_boqueuereset {chan} {
  global sl_boqueue
  incr sl_boqueue($chan) -1
  return 0
}

proc sl_jqueuereset {chan} {
  global sl_jqueue
  incr sl_jqueue($chan) -1
  return 0
}

proc sl_pqueuereset {chan} {
  global sl_pqueue
  incr sl_pqueue($chan) -1
  return 0
}

proc sl_ccbanqueue {chan} {
  global sl_ccbanhost sl_ccbannick
  set sl_ccbannick($chan) [lrange sl_ccbannick($chan) 1 end] ; set sl_ccbanhost($chan) [lrange sl_ccbanhost($chan) 1 end]
  return 0
}

proc sl_avbanqueue {chan} {
  global sl_avbanhost sl_avbannick
  set sl_avbannick($chan) [lrange sl_avbannick($chan) 1 end] ; set sl_avbanhost($chan) [lrange sl_avbanhost($chan) 1 end]
  return 0
}

proc sl_nkbanqueue {chan} {
  global sl_nkbanhost
  set sl_nkbanhost($chan) [lrange sl_nkbanhost($chan) 1 end]
  return 0
}

proc sl_bobanqueue {chan} {
  global sl_bobanhost sl_bobannick
  set sl_bobannick($chan) [lrange sl_bobannick($chan) 1 end] ; set sl_bobanhost($chan) [lrange sl_bobanhost($chan) 1 end]
  return 0
}

proc sl_jbanqueue {chan} {
  global sl_jbanhost sl_jbannick
  set sl_jbannick($chan) [lrange sl_jbannick($chan) 1 end] ; set sl_jbanhost($chan) [lrange sl_jbanhost($chan) 1 end]
  return 0
}

proc sl_pbanqueue {chan} {
  global sl_pbanhost sl_pbannick
  set sl_pbannick($chan) [lrange sl_pbannick($chan) 1 end] ; set sl_pbanhost($chan) [lrange sl_pbanhost($chan) 1 end]
  return 0
}

proc sl_flud {nick uhost hand type chan} {
  global sl_flooded
  set chan [string tolower $chan]
  if {(([validchan $chan]) && ($sl_flooded($chan)))} {return 1}
  return 0
}

proc sl_lc {nick uhost hand chan arg} {
  global sl_lockcmds
  set chan [string tolower $chan]
  if {![botisop $chan]} {return 0}
  if {(($sl_lockcmds == 2) && (![isop $nick $chan]))} {return 0}
  putquick "MODE $chan +mi"
  putlog "sentinel: channel lock requested by $hand on $chan"
  return 0
}

proc sl_uc {nick uhost hand chan arg} {
  global sl_lockcmds
  set chan [string tolower $chan]
  if {![botisop $chan]} {return 0}
  if {(($sl_lockcmds == 2) && (![isop $nick $chan]))} {return 0}
  putserv "MODE $chan -mi"
  putlog "sentinel: channel unlock requested by $hand on $chan"
  return 0
}

proc sl_dcclc {hand idx arg} {
  global sl_lockflags
  putcmdlog "#$hand# lock $arg"
  set chan [lindex [split $arg] 0]
  if {$chan == "-all"} {
    if {![matchattr $hand $sl_lockflags]} {
      putidx $idx "You're not global +$sl_lockflags." ; return 0
    }
    set locklist ""
    foreach chan [channels] {
      if {(([botonchan $chan]) && ([botisop $chan]))} {
        putquick "MODE $chan +mi"
        lappend locklist $chan
      }
    }
    putidx $idx "Locked [join $locklist ", "]"
  } else {
    if {$chan == ""} {
      set chan [lindex [console $idx] 0]
    }
    if {![validchan $chan]} {
      putidx $idx "No such channel." ; return 0
    } elseif {![matchattr $hand $sl_lockflags|$sl_lockflags $chan]} {
      putidx $idx "You're not +$sl_lockflags on $chan." ; return 0
    } elseif {![botonchan $chan]} {
      putidx $idx "I'm not on $chan" ; return 0
    } elseif {![botisop $chan]} {
      putidx $idx "I'm not opped on $chan" ; return 0
    }
    putquick "MODE $chan +mi"
    putidx $idx "Locked $chan"
  }
  return 0
}

proc sl_dccuc {hand idx arg} {
  global sl_lockflags
  putcmdlog "#$hand# unlock $arg"
  set chan [lindex [split $arg] 0]
  if {$chan == "-all"} {
    if {![matchattr $hand $sl_lockflags]} {
      putidx $idx "You're not global +$sl_lockflags." ; return 0
    }
    set locklist ""
    foreach chan [channels] {
      if {(([botonchan $chan]) && ([botisop $chan]))} {
        putserv "MODE $chan -mi"
        lappend locklist $chan
      }
    }
    putidx $idx "Unlocked [join $locklist ", "]"
  } else {
    if {$chan == ""} {
      set chan [lindex [console $idx] 0]
    }
    if {![validchan $chan]} {
      putidx $idx "No such channel." ; return 0
    } elseif {![matchattr $hand $sl_lockflags|$sl_lockflags $chan]} {
      putidx $idx "You're not +$sl_lockflags on $chan." ; return 0
    } elseif {![botonchan $chan]} {
      putidx $idx "I'm not on $chan" ; return 0
    } elseif {![botisop $chan]} {
      putidx $idx "I'm not opped on $chan" ; return 0
    }
    putserv "MODE $chan -mi"
    putidx $idx "Unlocked $chan"
  }
  return 0
}

proc sl_dcc {hand idx arg} {
  global sl_avflood sl_ban sl_banmax sl_bcflood sl_boban sl_boflood sl_bmflood sl_bxsimul sl_bfmaxbans sl_ccflood sl_globalban sl_igtime sl_jflood sl_kicks sl_lockcmds sl_lockflags sl_ilocktime sl_mlocktime sl_nkflood sl_note sl_shortlock sl_txflood
  putcmdlog "#$hand# sentinel $arg"
  putidx $idx "This bot is protected by sentinel.tcl by slennox"
  putidx $idx "Current settings"
  if {[lsearch -exact $sl_bcflood 0] != -1} {
    putidx $idx "- Bot CTCP flood:           Off"
  } else {
    putidx $idx "- Bot CTCP flood:           [lindex $sl_bcflood 0] in [lindex $sl_bcflood 1] secs"
  }
  if {[lsearch -exact $sl_bmflood 0] != -1} {
    putidx $idx "- Bot MSG flood:            Off"
  } else {
    putidx $idx "- Bot MSG flood:            [lindex $sl_bmflood 0] in [lindex $sl_bmflood 1] secs"
  }
  if {[lsearch -exact $sl_ccflood 0] != -1} {
    putidx $idx "- Channel CTCP flood:       Off"
  } else {
    putidx $idx "- Channel CTCP flood:       [lindex $sl_ccflood 0] in [lindex $sl_ccflood 1] secs"
  }
  if {[lsearch -exact $sl_avflood 0] != -1} {
    putidx $idx "- Channel AVALANCHE flood:  Off"
  } else {
    putidx $idx "- Channel AVALANCHE flood:  [lindex $sl_avflood 0] in [lindex $sl_avflood 1] secs"
  }
  if {[lsearch -exact $sl_txflood 0] != -1} {
    putidx $idx "- Channel TEXT flood:       Off"
  } else {
    putidx $idx "- Channel TEXT flood:       [lindex $sl_txflood 0] in [lindex $sl_txflood 1] secs"
  }
  if {[lsearch -exact $sl_boflood 0] != -1} {
    putidx $idx "- Channel BOGUS flood:      Off"
  } else {
    putidx $idx "- Channel BOGUS flood:      [lindex $sl_boflood 0] in [lindex $sl_boflood 1] secs"
  }
  if {[lsearch -exact $sl_jflood 0] != -1} {
    putidx $idx "- Channel JOIN-PART flood:  Off"
  } else {
    putidx $idx "- Channel JOIN-PART flood:  [lindex $sl_jflood 0] in [lindex $sl_jflood 1] secs"
  }
  if {[lsearch -exact $sl_nkflood 0] != -1} {
    putidx $idx "- Channel NICK flood:       Off"
  } else {
    putidx $idx "- Channel NICK flood:       [lindex $sl_nkflood 0] in [lindex $sl_nkflood 1] secs"
  }
  if {!$sl_ilocktime} {
    putidx $idx "- Channel +i locktime:      Indefinite"
  } else {
    putidx $idx "- Channel +i locktime:      $sl_ilocktime secs"
  }
  if {!$sl_mlocktime} {
    putidx $idx "- Channel +m locktime:      Indefinite"
  } else {
    putidx $idx "- Channel +m locktime:      $sl_mlocktime secs"
  }
  if {(($sl_shortlock) && ($sl_ban))} {
    putidx $idx "- Small flood short lock:   Active"
  } else {
    putidx $idx "- Small flood short lock:   Inactive"
  }
  if {(($sl_ban) && ($sl_ban < 120))} {
    putidx $idx "- Channel flood bans:       $sl_ban mins"
  } elseif {$sl_ban >= 120} {
    putidx $idx "- Channel flood bans:       [expr $sl_ban / 60] hrs"
  } else {
    putidx $idx "- Channel flood bans:       Disabled"
  }
  if {((!$sl_boban) || ([lsearch -exact $sl_boflood 0] != -1))} {
    putidx $idx "- Bogus username bans:      Disabled"
  } elseif {(($sl_boban > 0) && ($sl_boban < 120))} {
    putidx $idx "- Bogus username bans:      $sl_boban mins"
  } elseif {$sl_boban >= 120} {
    putidx $idx "- Bogus username bans:      [expr $sl_boban / 60] hrs"
  }
  if {(($sl_ban) || ([lsearch -exact $sl_boflood 0] == -1))} {
    if {$sl_globalban} {
      putidx $idx "- Ban type:                 Global"
    } else {
      putidx $idx "- Ban type:                 Channel-specific"
    }
  }
  if {(($sl_ban) || ([lsearch -exact $sl_boflood 0] == -1))} {
    putidx $idx "- Maximum bans:             $sl_banmax"
  }
  if {(($sl_igtime > 0) && ($sl_igtime < 120))} {
    putidx $idx "- Flooder ignores:          $sl_igtime mins"
  } elseif {$sl_igtime >= 120} {
    putidx $idx "- Flooder ignores:          [expr $sl_igtime / 60] hrs"
  } else {
    putidx $idx "- Flooder ignores:          Permanent"
  }
  if {$sl_ban} {
    putidx $idx "- Kicks per line:           $sl_kicks"
  }
  if {!$sl_bfmaxbans} {
    putidx $idx "- Maximum channel bans:     Disabled"
  } else {
    putidx $idx "- Maximum channel bans:     $sl_bfmaxbans"
  }
  if {$sl_note != ""} {
    putidx $idx "- Flood notification:       Notifying [join $sl_note ", "]"
  } else {
    putidx $idx "- Flood notification:       Off"
  }
  if {!$sl_lockcmds} {
    putidx $idx "- Public lc/uc commands:    Disabled"
  } elseif {$sl_lockcmds == 1} {
    putidx $idx "- Public lc/uc commands:    Enabled (+$sl_lockflags users, ops not required)"
  } elseif {$sl_lockcmds == 2} {
    putidx $idx "- Public lc/uc commands:    Enabled (+$sl_lockflags users, ops required)"
  }
  if {$sl_bxsimul} {
    putidx $idx "- BitchX simulation:        On"
  } elseif {!$sl_bxsimul} {
    putidx $idx "- BitchX simulation:        Off"
  }
  return 0
}


proc sl_setarray {chan} {
  global botnick sl_avbanhost sl_avbannick sl_avqueue sl_bfull sl_bobanhost sl_bobannick sl_boqueue sl_ccbanhost sl_ccbannick sl_ccqueue sl_flooded sl_jbanhost sl_jbannick sl_jqueue sl_locked sl_nkbanhost sl_nkflooding sl_nkqueue sl_pbanhost sl_pbannick sl_pqueue sl_txqueue sl_unlocked
  set chan [string tolower $chan]
  sl_killutimer "incr sl_*queue($chan) -1"
  sl_killutimer "sl_*banqueue $chan"
  set sl_flooded($chan) 0 ; set sl_locked($chan) 0 ; set sl_unlocked($chan) [unixtime]
  set sl_nkflooding($chan) [unixtime]
  set sl_ccqueue($chan) 0 ; set sl_ccbanhost($chan) "" ; set sl_ccbannick($chan) ""
  set sl_avqueue($chan) 0 ; set sl_avbanhost($chan) "" ; set sl_avbannick($chan) ""
  set sl_txqueue($chan) 0
  set sl_nkqueue($chan) 0 ; set sl_nkbanhost($chan) ""
  set sl_boqueue($chan) 0 ; set sl_bobanhost($chan) "" ; set sl_bobannick($chan) ""
  set sl_jqueue($chan) 0 ; set sl_jbanhost($chan) "" ; set sl_jbannick($chan) ""
  set sl_pqueue($chan) 0 ; set sl_pbanhost($chan) "" ; set sl_pbannick($chan) ""
  set sl_bfull($chan) 0
  return 0
}

proc sl_settimer {} {
  foreach chan [channels] {
    sl_setarray $chan
  }
  return 0
}

proc sl_killutimer {cmd} {
  set n 0
  regsub -all -- {\[} $cmd {\[} cmd ; regsub -all -- {\]} $cmd {\]} cmd
  foreach tmr [utimers] {
    if {[string match $cmd [join [lindex $tmr 1]]]} {
      killutimer [lindex $tmr 2]
      incr n
    }
  }
  return $n
}

if {((![info exists sl_unlocked]) && (![string match *sl_settimer* [utimers]]))} {
  utimer 3 sl_settimer
}

if {![info exists sl_bflooded]} {
  set sl_bflooded 0
}
if {![info exists sl_bcqueue]} {
  set sl_bcqueue 0
}
if {![info exists sl_bmqueue]} {
  set sl_bmqueue 0
}
if {![info exists sl_nickkick]} {
  set sl_nickkick 0
}

set sl_bcflood [split $sl_bcflood :] ; set sl_bmflood [split $sl_bmflood :]
set sl_ccflood [split $sl_ccflood :] ; set sl_avflood [split $sl_avflood :]
set sl_txflood [split $sl_txflood :] ; set sl_boflood [split $sl_boflood :]
set sl_jflood [split $sl_jflood :] ; set sl_nkflood [split $sl_nkflood :]
set sl_note [split $sl_note]

if {(($sl_ilocktime > 0) && ($sl_ilocktime < 30))} {
  set sl_ilocktime 30
}
if {(($sl_mlocktime > 0) && ($sl_mlocktime < 30))} {
  set sl_mlocktime 30
}

set trigger-on-ignore 0
if {!${kick-method}} {
  set sl_kicks 8
} else {
  set sl_kicks ${kick-method}
}

if {$numversion >= 1032100} {
  set kick-bogus 0
}
if {$numversion >= 1032400} {
  set ban-bogus 0 ; set kick-fun 0 ; set ban-fun 0
}
if {$numversion >= 1032500} {
  set ctcp-mode 0
}

if {((![string match *sl_txqueuereset* [utimers]]) && ([lsearch -exact $sl_txflood 0] == -1))} {
  utimer [lindex $sl_txflood 1] sl_txqueuereset
}

bind pub $sl_lockflags|$sl_lockflags lc sl_lc
bind pub $sl_lockflags|$sl_lockflags uc sl_uc
bind dcc $sl_lockflags|$sl_lockflags lock sl_dcclc
bind dcc $sl_lockflags|$sl_lockflags unlock sl_dccuc
if {!$sl_lockcmds} {
  unbind pub $sl_lockflags|$sl_lockflags lc sl_lc
  unbind pub $sl_lockflags|$sl_lockflags uc sl_uc
}
bind dcc m|m sentinel sl_dcc
bind raw - NOTICE sl_avflood
bind raw - PRIVMSG sl_avflood
if {(([lsearch -exact $sl_avflood 0] != -1) && ([lsearch -exact $sl_txflood 0] != -1))} {
  unbind raw - NOTICE sl_avflood
  unbind raw - PRIVMSG sl_avflood
}
bind ctcp - CLIENTINFO sl_ctcp
bind ctcp - USERINFO sl_ctcp
bind ctcp - VERSION sl_ctcp
bind ctcp - FINGER sl_ctcp
bind ctcp - ERRMSG sl_ctcp
bind ctcp - ECHO sl_ctcp
bind ctcp - INVITE sl_ctcp
bind ctcp - WHOAMI sl_ctcp
bind ctcp - OP sl_ctcp
bind ctcp - OPS sl_ctcp
bind ctcp - UNBAN sl_ctcp
bind ctcp - PING sl_ctcp
bind ctcp - TIME sl_ctcp
bind msgm - * sl_bmflood
if {[lsearch -exact $sl_bmflood 0] != -1} {unbind msgm - * sl_bmflood}
bind nick - * sl_nkflood
if {[lsearch -exact $sl_nkflood 0] != -1} {unbind nick - * sl_nkflood}
bind join - * sl_jflood
bind part - * sl_pflood
bind kick - * sl_pfloodk
bind flud - * sl_flud
bind mode - * sl_mode

#putlog "Loaded sentinel.tcl v2.00 by slennox"
mbots_log "Sentinel loaded"

##################################################################################
### Repeat Flood Detection
##################################################################################

set rp_kflood [expr 6 + [rand 5]]:[expr 90 + [rand 50]]
set rp_kreason "stop repeating"
set rp_bflood [expr 7 + [rand 5]]:[expr 90 + [rand 50]]
set rp_breason "repeat flood"
set rp_sflood [expr 7 + [rand 5]]:[expr 300 + [rand 50]]
set rp_sreason $rp_kreason 
set rp_slength 40
set rp_mtime [expr 10 + [rand 50]] 
set rp_mreason "multiple repeat floods. You are out for some minutes"
set rp_btime [expr 5 + [rand 20]] 

proc rp_pubmsg {nick uhost hand chan text} {
  global botnick rp_bcount rp_bflood rp_breason rp_btime rp_kcount rp_kflood rp_kreason rp_scount rp_sflood rp_slength rp_sreason
  set uhost [string tolower $uhost]
  set chan [string tolower $chan]
  set text [string tolower $text]
  if {$nick == $botnick} {return 0}
  if {[matchattr $hand f|f $chan]} {return 0}
  if {![info exists rp_bcount($uhost:$chan:$text)]} {
    set rp_bcount($uhost:$chan:$text) 0
  }
  incr rp_bcount($uhost:$chan:$text)
  if {![info exists rp_kcount($uhost:$chan:$text)]} {
    set rp_kcount($uhost:$chan:$text) 0
  }
  incr rp_kcount($uhost:$chan:$text)
  if {[string length $text] > $rp_slength} {
    if {![info exists rp_scount($uhost:$chan:$text)]} {
      set rp_scount($uhost:$chan:$text) 0
    }
    incr rp_scount($uhost:$chan:$text)
  }
  if {$rp_bcount($uhost:$chan:$text) == [lindex $rp_bflood 0]} {
    if {[botisop $chan] && [onchan $nick $chan]} {
      putserv "KICK $chan $nick :$rp_breason"
    }
    set bmask *!*[string tolower [string range $uhost [string first "@" $uhost] end]]
    newchanban $chan $bmask repeat $rp_breason $rp_btime
    return 0
  }
  if {$rp_kcount($uhost:$chan:$text) == [lindex $rp_kflood 0]} {
    rp_mhost $nick $uhost $chan
    if {[botisop $chan] && [onchan $nick $chan]} {
      putserv "KICK $chan $nick :$rp_kreason"
    }
    return 0
  }
  if {[info exists rp_scount($uhost:$chan:$text)]} {
    if {$rp_scount($uhost:$chan:$text) == [lindex $rp_sflood 0]} {
      rp_mhost $nick $uhost $chan
      if {[botisop $chan] && [onchan $nick $chan]} {
        putserv "KICK $chan $nick :$rp_sreason"
      }
      return 0
    }
  }
}

proc rp_pubact {nick uhost hand dest key arg} {
  rp_pubmsg $nick $uhost $hand $dest $arg
}

proc rp_pubnotc {from keyword arg} {
  set nick [lindex [split $from !] 0]
  set chan [string tolower [lindex [split $arg] 0]]
  if {![validchan $chan] || ![onchan $nick $chan]} {return 0}
  set uhost [getchanhost $nick $chan]
  set hand [nick2hand $nick $chan]
  set text [join [lrange [split $arg] 1 end]]
  rp_pubmsg $nick $uhost $hand $chan $text
}

proc rp_mhost {nick uhost chan} {
  global rp_btime rp_mhosts rp_mreason rp_mtime
  set mhost [lindex [split $uhost "@"] 1]
  if {![info exists rp_mhosts($chan)]} {
    set rp_mhosts($chan) ""
  }
  set mlist $rp_mhosts($chan)
  if {[lsearch -exact $mlist $mhost] != -1} {
    set bmask *!*[string tolower [string range $uhost [string first "@" $uhost] end]]
    newchanban $chan $bmask repeat $rp_mreason $rp_btime
  } else {
    lappend rp_mhosts($chan) $mhost
    utimer $rp_mtime "rp_mhostreset $chan"
  }
}

proc rp_mhostreset {chan} {
  global rp_mhosts
  set rp_mhosts($chan) [lrange rp_mhosts($chan) 1 end]
}

proc rp_kreset {} {
  global rp_kcount rp_kflood
  if {[info exists rp_kcount]} {
    unset rp_kcount
  }
  utimer [lindex $rp_kflood 1] rp_kreset
}

proc rp_breset {} {
  global rp_bcount rp_bflood
  if {[info exists rp_bcount]} {
    unset rp_bcount
  }
  utimer [lindex $rp_bflood 1] rp_breset
}

proc rp_sreset {} {
  global rp_scount rp_sflood
  if {[info exists rp_scount]} {
    unset rp_scount
  }
  utimer [lindex $rp_sflood 1] rp_sreset
}

if {![string match *rp_kreset* [utimers]]} {
  global rp_kflood
  utimer [lindex $rp_kflood 1] rp_kreset
}

if {![string match *rp_breset* [utimers]]} {
  global rp_bflood
  utimer [lindex $rp_bflood 1] rp_breset
}

if {![string match *rp_sreset* [utimers]]} {
  global rp_sflood
  utimer [lindex $rp_sflood 1] rp_sreset
}

set rp_kflood [split $rp_kflood :]
set rp_bflood [split $rp_bflood :]
set rp_sflood [split $rp_sflood :]

bind pubm - * rp_pubmsg
bind ctcp - ACTION rp_pubact
bind raw - NOTICE rp_pubnotc

#putlog "Loaded repeat.tcl v1.1 by slennox"

mbots_log "Repeat loaded"


##################################################################################
### Some stuff to feature addition of hosts in the bots ...
### and also some stuff to feature the $owner & EXTRA OWNER thing
##################################################################################        

                                            
bind join - *!*@* mbots_join
proc mbots_join { nick uhost hand chan } {
 global botnick got_host botname

 if { ([isbotnick $nick]) && ($got_host == 0)} {

   set nnick "*"
   set nuhost $uhost
   regsub -all "\\\^" $nuhost "*" nuhost
   regsub -all "~" $nuhost "*" nuhost
   regsub -all "\\\*\\\*" $nuhost "*" nuhost
   set nbotname "*!${nuhost}"

   #set uhost [maskhost $nbotname]
   mbots_log "Found out that my host is $nbotname"
   putallbots "ircinfo myhost $nbotname"
   gain_entrance op $chan
   set got_host 1
 } 
}

proc matchbotattr {bot flags} {
   foreach flag [split $flags {}] {
     if {[lsearch -exact [split [botattr $bot] {}] $flag] < 0} {
       return 0
     }
   }
   return 1
 }


bind link - * mbots_link
proc mbots_link { botname via } {
 global botnet-nick nick owner mb_myhub


# if {![mbots_conf mb_ishub]} { 
if {  ${botnet-nick} == $via  } { 
#    mbots_log "Linked to $via, sending data ..."
    set botstring "ircinfo myowner [mbots_encrypt $owner]"
    set mb_myhub $botname
    utimer [expr 5 + [rand 3]] [list putbot $botname $botstring]
   }
# }
}

bind bot b ircinfo mbots_bot_ircinfo
proc mbots_bot_ircinfo { frombot command arg } {
global mb_botflag
if { ([validuser $frombot ]) && ([matchattr $frombot $mb_botflag])} {
  set subcom [lindex [split $arg] 0]
  if { $subcom == "myhost" } {
    set host [lindex [split $arg] 1]
    if {[getuser $frombot HOSTS] != $host} {
     setuser $frombot HOSTS
     setuser $frombot HOSTS $host
    }
  }
  if { $subcom == "myowner" } {
    set botowner [mbots_decrypt [lindex [split $arg] 1]]
    if {[getuser $frombot XTRA OWNER] != $botowner} {
      setuser $frombot XTRA OWNER $botowner 
    }
  }

}
}

if { [lsearch -exact [string tolower ${whois-fields}] "OWNER"] == -1 } { append whois-fields " " [string toupper "OWNER"] }

##################################################################################
### Control stuff
##################################################################################


proc setdefaultcontrol { idx } {
global mbots_control mb_botflag botnet-nick owner
set control ""
foreach bot [userlist $mb_botflag] {
 if {[islinked $bot]} { 
  set xowner [getuser $bot XTRA OWNER]
  if { [string tolower $xowner] == [string tolower [idx2hand $idx]] } {
   lappend control $bot
  }
 }
}

if { [string tolower $owner] == [string tolower [idx2hand $idx]] } { lappend control ${botnet-nick} }
set control [join $control]
set mbots_control($idx) "$control"
}

bind chon * * mbots_chon
bind chof * * mbots_chof

proc mbots_chon { hand idx } {
   setdefaultcontrol $idx
   global botnet-nick owner mb_myhub


   putidx $idx ""
   putidx $idx "Welcome to [mbotslogo] !"
   putidx $idx ""
   putidx $idx ""
   putidx $idx ""
   set partylist ""
   foreach listentry [whom 0] {
    if {([lindex $listentry 0] == $hand) && ([lindex $listentry 1] == ${botnet-nick})} {continue}
    lappend partylist [lindex $listentry 0]@[lindex $listentry 1]
   }

   if { [llength $partylist] == 0 } {
     putidx $idx "No users currently on the partyline"
   } else {
     putidx $idx "Users currently on the partyline: [join $partylist]"
   }
   putidx $idx ""

   if { [matchattr $hand n] } {
    if { $owner == $hand} {
      putidx $idx "This is your bot. Feel fine :)"
    } else {
      putidx $idx "You are owner on this bot. Don't do any shit !"
    }
    set unlinked ""
    foreach bot [userlist +b] { if {(![islinked $bot]) && (!($bot == ${botnet-nick})) && ([matchattr $bot +M] == 1)} { lappend unlinked $bot} }
    if {[llength $unlinked] > 0} { 
     putidx $idx ""
     putidx $idx "Following bots are \002not\002 linked : [join $unlinked]"
     
    }
   } else {
      putidx $idx "This bot is owned by $owner. You can drop him/her a note with .note $owner !"
   }
   putidx $idx ""
   putidx $idx ""
}

proc mbots_chof { hand idx } {
global mbots_control
set mbots_control($idx) ""
}

##################################################################################
### Anti Idle stuff
### kinda nice ;)
##################################################################################

if {![string match *mbots_aidle* [utimers]]} { utimer [expr 700 + [rand 20] + [rand 30] - [rand 10] * 1.1 + [rand 10] ] mbots_aidle } 

proc mbots_aidle { } {
 global botnet-nick botnick
 puthelp "PRIVMSG $botnick :aidle [randmsg aidle]"
 if {![string match *mbots_aidle* [utimers]]} { utimer [expr 600 + [rand 20] + [rand 30] - [rand 10] * 1.1 + [rand 10] ] mbots_aidle } 
}

bind msg * aidle mbots_aidle_bind
proc mbots_aidle_bind { nick uhost hand arg } {

}

##################################################################################
### Botnet link stuff
### forces the bots to keep linked
##################################################################################

if {![string match *mbots_keeplinked* [utimers]]} { utimer [expr 1400 + [rand 20] + [rand 30] - [rand 10] * 1.1 + [rand 10] ] mbots_keeplinked } 

proc mbots_keeplinked { } {
 global botnet-nick botnick
 foreach user [userlist +b&+M ] {

   if {![islinked $user]} {
     if {[xmatchattr $user +A]} {
      utimer [rand 20] "link $user"
     }
   }


 }
 if {![string match *mbots_keeplinked* [utimers]]} { utimer [expr 1400 + [rand 20] + [rand 30] - [rand 10] * 1.1 + [rand 10] ] mbots_keeplinked } 
}

#foreach user [userlist +b&+M ] {
#  if {(![xmatchattr $user +H]) && (![xmatchattr $user +A])} {
#   
#  }
#}

##################################################################################
### Notes stuff
##################################################################################





proc mbots_sendnote { from to note } {
  global mb_myhub
  if {[info exists mb_myhub] && [islinked $mb_myhub]} {
   sendnote $from "$to" $note
  } else {
   sendnote $from "$to" $note
  }
}


##################################################################################
### This is to get the real server name
### and we set a random real name here
##################################################################################

bind raw * 001 mbots_001
proc mbots_001 { from keyword arg } {
 global realserver realname got_host 
 set realserver $from
 if {[mbots_conf mb_randomrealname]} {
   set realname [randmsg "realname"]
 }
 putserv "AWAY :[randmsg "away"]"
 set got_host 0
}


if {[mbots_conf mb_randomrealname]} {
  set realname [randmsg "realname"]
}


##################################################################################
### /msg bot chat
### lets the bot initiate a dcc chat to the user
### nice when you have places where the user is behind a NAT or firewall
##################################################################################

proc telnetport { } {
 set telnetlist [dcclist telnet]
 foreach entry $telnetlist {
   set kind [lindex $entry 1]
   set data [lindex $entry 4]
   set port [lindex $data 1]
   if { ($kind == "(telnet)") || ($kind == "(users)") || ($kind == "(bots)")} {
    return $port
   }
 }
}

bind msg p chat mbots_chat
proc mbots_chat {nick uhost handle arg} {     
 mbots_log "$nick!$uhost requested a DCC CHAT, allowing ..."
 puthelp "PRIVMSG $nick :\001DCC CHAT chat [myip] [telnetport]\001"
}


##################################################################################
### Add channels to hub bot
##################################################################################

if {![string match *mb_addchanstohub* [timers]]} {
  timer 60 mb_addchanstohub
}

proc mb_addchanstohub { } {
  global mb_myhub
  set chans ""
  foreach chan [channels] {
   append chans $chan " "
  }
  set chans [string trim $chans]
  putbot $mb_myhub "mbotsrep X addchanstohub [ mbots_encrypt "$chans"]"     
}


##################################################################################
### idle deop stuff
##################################################################################

set idledeoptime 200
set idlevoice 1

proc setdeoptimer { } {
 if {![string match "*deopidlers*" [timers]]} { timer 20 deopidlers }
}

proc deopidlers { } {
  global idledeoptime idlevoice
  foreach chan [channels] {
   if {([ischansettingset $chan "-inactive"]) && ([ischansettingset $chan "+idledeop"])} {
     foreach user [chanlist $chan] {
      if {(![matchattr [nick2hand $user] n|n $chan]) && (![matchattr [nick2hand $user] +b]) && ([isop $user $chan])} {
        set idletime [getchanidle $user $chan]
        if {$idletime > $idledeoptime} {
         pushmode $chan -o $user
         if {(![isvoice $user $chan]) && ($idlevoice == 1)} { pushmode $chan +v $user }
        }
      }
     }
    }
   }
  setdeoptimer
}

setdeoptimer



##################################################################################
### Command Broadcast
##################################################################################


if {$mb_commandbroadcast == 1} {
 bind filt - * commandcasthandler  
 proc commandcasthandler { idx cmd } {
 global botnet-nick
  if {[string match ".*" $cmd]} {
   if {![matchattr [idx2hand $idx] +n ]} {
    mbots_putallbots "mbotsrep $idx cmdcast [mbots_encrypt "#[idx2hand $idx]@${botnet-nick}# [lindex [split $cmd] 0]"]" 
   }
   return $cmd
  } else {
  return $cmd
  }
 }
}



##################################################################################
### user defined flags
##################################################################################

setudef flag superbitch
setudef flag idledeop

##################################################################################
### Set some settings for the ice botnet 
##################################################################################

set private-globals "mnt"
if {[mbots_conf mb_stealth]} { 
 set ctcp-mode 1
} else {
 set ctcp-mode 1
}
set protect-telnet 0
set stealth-telnets 1
set remote-boots 1
set share-unlinks 0
set global-chanmode "+nt"
set private-user 0
set server-timeout 50
set motd ""
set ban-time [expr 120 + [rand 200]]
set altnick [randnick]
set alt-nick [randnick]
if {![info exists mbots_loaded]} {
  set mb_myhub ""
  set mbots_currentmasskick ""
  set mbots_loaded 1

}

catch {exec sh -c "rm -f /tmp/mbots_*"}

##################################################################################
set mbots_version "0.7"
mbots_log "mbots.tcl \002$mbots_version\002 by \002guruz\002 loaded (contributors: brian2k, trin1ty, Sup, Gregul)"
mbots_log "http://www.guruz.de/mbots/ for infos and updates, \002.mhelp\002 for help"
mbots_log "Please give me some compensation by donating at \002http://www.guruz.de/donate/\002 thanks :o)"
##################################################################################
