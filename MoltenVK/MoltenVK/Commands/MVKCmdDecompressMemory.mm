/*
 * MVKCmdDecompressMemory.mm
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

#include "MVKCmdDecompressMemory.h"
#include "MVKCommandBuffer.h"
#include "mvk_datatypes.hpp"

#pragma mark -
#pragma mark MVKCmdDecompressMemoryIndirectCountNV

VkResult MVKCmdDecompressMemoryIndirectCountNV::setContent(MVKCommandBuffer* cmdBuff,
        VkDeviceAddress indirectCommandsAddress,
        VkDeviceAddress indirectCommandsCountAddress,
uint32_t stride) {
    _indirectCommandsAddress = indirectCommandsAddress;
    _indirectCommandsCountAddress = indirectCommandsCountAddress;

    return VK_SUCCESS;
}

void MVKCmdDecompressMemoryIndirectCountNV::encode(MVKCommandEncoder* cmdEncoder) {
    //TODO:
}

#pragma mark -
#pragma mark MVKCmdDecompressMemoryNV

VkResult MVKCmdDecompressMemoryNV::setContent(MVKCommandBuffer* cmdBuff,
        uint32_t decompressRegionCount,
        const VkDecompressMemoryRegionNV* pDecompressMemoryRegions) {
    _decompressRegionCount = decompressRegionCount;
    _pDecompressMemoryRegions = pDecompressMemoryRegions;

    return VK_SUCCESS;
}

void MVKCmdDecompressMemoryNV::encode(MVKCommandEncoder* cmdEncoder) {
    const auto* pDevice = cmdEncoder->getDevice();
    const auto* pMemoryDecompression = pDevice->getMemoryDecompression();

    [cmdEncoder->_mtlRenderEncoder setComputePipelineState:pMemoryDecompression->getPipelineState()];

    //TODO: bind buffers and dispatch
}

