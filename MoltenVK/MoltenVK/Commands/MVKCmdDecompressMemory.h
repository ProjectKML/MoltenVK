/*
 * MVKCmdDecompressMemory.h
 *
 * Copyright (c) 2015-2024 The Brenwill Workshop Ltd. (http://www.brenwill.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include "MVKCommand.h"

#import <Metal/Metal.h>

#pragma mark -
#pragma mark MVKCmdDecompressMemoryIndirectCountNV

class MVKCmdDecompressMemoryIndirectCountNV : public MVKCommand {
public:
    VkResult setContent(MVKCommandBuffer* cmdBuff,
            VkDeviceAddress indirectCommandsAddress,
            VkDeviceAddress indirectCommandsCountAddress,
            uint32_t stride);

    void encode(MVKCommandEncoder* cmdEncoder) override;

protected:
    MVKCommandTypePool<MVKCommand>* getTypePool(MVKCommandPool* cmdPool) override;

    VkDeviceAddress _indirectCommandsAddress;
    VkDeviceAddress _indirectCommandsCountAddress;
    uint32_t _stride;
};

#pragma mark -
#pragma mark MVKCmdDecompressMemoryNV

class MVKCmdDecompressMemoryNV : public MVKCommand {
public:
    VkResult setContent(MVKCommandBuffer* cmdBuff,
        uint32_t decompressRegionCount,
        const VkDecompressMemoryRegionNV* pDecompressMemoryRegions);

    void encode(MVKCommandEncoder* cmdEncoder) override;

protected:
    MVKCommandTypePool<MVKCommand>* getTypePool(MVKCommandPool* cmdPool) override;

    uint32_t _decompressRegionCount;
    const VkDecompressMemoryRegionNV* _pDecompressMemoryRegions;
};
