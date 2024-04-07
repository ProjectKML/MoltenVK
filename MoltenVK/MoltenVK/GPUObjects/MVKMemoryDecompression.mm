/*
 * MVKDecompressMemory.mm
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

#include "MVKMemoryDecompression.h"
#include "../Commands/MVKCmdDecompressMemorySource.h"

VkResult MVKMemoryDecompression::init(id<MTLDevice> device) {
    auto* pData = [NSData dataWithBytes:NV_DECOMPRESS_MEMORY_LIB length:sizeof(NV_DECOMPRESS_MEMORY_LIB) / sizeof(NV_DECOMPRESS_MEMORY_LIB[0])];
    NSError* pError = nil;
    auto library = [device newLibraryWithData:pData error:&pError];
    if (!library) {
        MVKLogError("Failed to create library for NV_MEMORY_DECOMPRESSION: %s", pError.localizedDescription);
        return VK_ERROR_INITIALIZATION_FAILED;
    }

    auto kernelFunction = [library newFunctionWithName:@"CSMain"];
    if (!kernelFunction) {
        MVKLogError("Failed to create kernel function for NV_MEMORY_DECOMPRESSION: %s", pError.localizedDescription);
        return VK_ERROR_INITIALIZATION_FAILED;
    }

    auto* pPipelineDescriptor = [[MTLComputePipelineDescriptor alloc] init];
    pPipelineDescriptor.computeFunction = kernelFunction;

    _pipelineState = [device newComputePipelineStateWithDescriptor:pipelineDescriptor error:&pError];
    if (!_pipelineState) {
        MVKLogError("Failed to create pipeline state for NV_MEMORY_DECOMPRESSION: %s", pError.localizedDescription);
        return VK_ERROR_INITIALIZATION_FAILED;
    }

    [pPpipelineDescriptor release];
    [kernelFunction release];
    [library release];
    [_pData release];

    return VK_SUCCESS;
}

MVKMemoryDecompression::~MVKMemoryDecompression() {
    [_pipelineState release];
}