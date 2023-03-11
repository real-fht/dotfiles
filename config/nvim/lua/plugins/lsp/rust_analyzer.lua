return {
    settings = {
        ["rust-analyzer"] = {
            -- Cache all the current workspace when loading rust-analyzer
            cachePriming = { numThreads = 4, enable = true },
            checkOnSave = { enable = true },
            completion = {
                autoimport = { enable = true },
                autoself = { enable = true },
            },
        },
    },
}
