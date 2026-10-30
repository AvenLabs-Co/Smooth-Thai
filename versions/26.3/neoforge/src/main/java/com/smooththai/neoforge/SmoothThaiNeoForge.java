package com.smooththai.neoforge;

import com.smooththai.Constants;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.common.Mod;

@Mod(Constants.MOD_ID)
public class SmoothThaiNeoForge {

    public SmoothThaiNeoForge(IEventBus eventBus) {
        Constants.LOG.info("SmoothThai initialized");
    }
}
