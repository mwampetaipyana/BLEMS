<template>
    <div class="flex flex-col space-y-8">
        <div class="w-full flex flex-row">
            <div class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                    <span class="material-symbols-outlined">
                        inventory_2
                    </span>
                </div>
                <div class=" flex flex-col h-full">
                    <div class="font-semibold text-main  text-[20px]"> 
                        {{count}}
                    </div>
                    <div class="font-semibold text-gray-500  text-[13px]"> 
                        Cases
                    </div>
                </div>
            </div>     
        </div>

        <!-- <div class="w-full flex flex-row">
            <div  class="relative flex h-fit flex-row space-x-4 items-center w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
            
                <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                    <span class="material-symbols-outlined">
                        description
                    </span>
                </div>
                <div class=" flex flex-col h-full">
                    <div class="font-semibold text-main  text-[20px]"> 
                        30
                    </div>
                    <div class="font-semibold text-gray-500  text-[13px]"> 
                        Evidence Files
                    </div>
                </div>
            
            </div>
            
            <div class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
            
                <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                    <span class="material-symbols-outlined">
                        inventory_2
                    </span>
                </div>
                <div class=" flex flex-col h-full">
                    <div class="font-semibold text-main  text-[20px]"> 
                        14
                    </div>
                    <div class="font-semibold text-gray-500  text-[13px]"> 
                        Cases
                    </div>
                </div>
            </div>
        </div> -->
    </div>

</template>


<script setup>
 import {ref, onMounted} from "vue"
 import { getSignerContract, getNumber } from "@/utils/contractService";

const count = ref(0)

 const getCount =async ()=>{
    const {signer,contract} = await getSignerContract()
    const cases = await contract.getmyCase(signer.getAddress());
    count.value = cases.length;
}

 onMounted(async()=>{
    await getCount();
 })


</script>