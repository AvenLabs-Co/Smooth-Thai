package com.smooththai.fabric;

import com.smooththai.Constants;
import net.fabricmc.api.ModInitializer;

public class SmoothThaiFabric implements ModInitializer {

    @Override
    public void onInitialize() {
        Constants.LOG.info("SmoothThai initialized");
    }
}
