######################################################
#
#   Sample Main file. This file is run when the server
#   starts up, or the plugin is reloaded. It can be used
#   as an opportunity to register events or do other things
#   when the server initially starts. Variables defined here
#   will go out of scope, so you can't assign() something and
#   then use it in a command, for instance.
#
######################################################

/*
assign(@server_name, '<Server Name>')
*/

#Echo out a server greeting to the console
console('Welcome to this server, which is running CommandHelper! (Change this message in plugins/CommandHelper/main.ms)')

#Bind an event to the player join, and tell ops hello. We send in
#@server_name, so we can use it inside the event handler

/*
bind(player_join, null, null, @event, @server_name,
    #if the player is an op, let's send them a welcome message
    if(pisop(@event[player]), tmsg(@event[player], 'Welcome to '.@server_name.' (Change this message in plugins/CommandHelper/main.ms)'))
)
*/

bind(item_pre_enchant, null, null, @event, @server_name,
    #msg('')
    #msg(@event)
    
    #modify_event(item, array(type: 1))
)

bind(item_enchant, null, null, @event, @server_name,
    #msg('')
    #msg(@event)
    
    assign(@rand, rand(1))
    console(@rand, false)
    if(equals(@rand, 0),
      if(equals(@event[levels], 10),
        modify_event(enchants, array(array(etype: 'ARROW_FIRE', elevel: 0)))
      )
      
      if(equals(@event[levels], 20),
        #msg(@event[levels])
        modify_event(enchants, array(array(etype: 'ARROW_FIRE', elevel: -1)))
        
        assign(@level, get_itemmeta(@event[player], pinfo(@event[player], 15)))
        if(nequals(@level[enchants], null),
          assign(@level, @level[enchants])
          assign(@level, @level[0])
          assign(@level, @level[elevel])
        )
        set_itemmeta(null, array(lore: array('Wither I'), enchants: array('Wither I')))
      )
    )
)

bind(entity_damage, null, null, @event,
    console(@event, false)
    
    if(equals(@event[cause], 'PROJECTILE'),
      #msg('1')
      if(equals(array_index_exists(@event, player), true),
        #msg('2')
        assign(@player, @event[player])
      )
      if(equals(array_index_exists(@event, shooter), true),
        #msg('3')
        assign(@shooter, @event[shooter])
      )
      
      tmsg(@shooter, concat('+', @event[amount]))
      
      assign(@level, get_itemmeta(@shooter, pinfo(@shooter, 15)))
      if(nequals(@level[enchants], null),
        #msg('4')
        assign(@level, @level[enchants])
        assign(@level, @level[0])
        assign(@level, @level[elevel])
        #msg(@level)
        
      )
      
      if(equals(@level, 0),
        #msg('5')
        if(equals(@event[type], 'PLAYER'),
          #msg('6')
          set_peffect(@player, 20, 2, 8, false)
        )
        
        if(nequals(@event[type], 'PLAYER'),
          #msg('7')
          set_mob_effect(@event[id], 20, 2, 8, false)
        )
      )
      
      if(equals(@level, 65535),
        #msg('5')
        if(equals(@event[type], 'PLAYER'),
          #msg('6')
          set_peffect(@player, 20, 4, 16, false)
        )
        
        if(nequals(@event[type], 'PLAYER'),
          #msg('7')
          set_mob_effect(@event[id], 20, 4, 16, false)
        )
      )
    )
  #msg('8')
)