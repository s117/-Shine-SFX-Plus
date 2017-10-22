SFX_PLUS_DEBUG_LOG = true

function Dbg( ... )
    arg = {...}
    if SFX_PLUS_DEBUG_LOG then
        Log(unpack(arg))
    end
end
