<template>
    <div class="flex flex-col space-y-8">
        <div class="w-full flex flex-row">
                <div  class="relative flex h-fit flex-row flex-wrap space-x-4 items-center w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                
                    <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                        <span class="material-symbols-outlined">
                            gavel
                        </span>
                    </div>
                    <div class=" flex flex-col h-full">
                        <div class="font-semibold text-main  text-[20px]"> 
                            {{count.judges}}
                        </div>
                        <div class="font-semibold text-gray-500  text-[13px]"> 
                            Judges
                        </div>
                    </div>
                
                </div>
                <div class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                    <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                        <span class="material-symbols-outlined">
                            balance
                        </span>
                    </div>
                    <div class=" flex flex-col h-full">
                        <div class="font-semibold text-main  text-[20px]"> 
                            {{count.prosecutors}}
                        </div>
                        <div class="font-semibold text-gray-500  text-[13px]"> 
                           Prosecutors
                        </div>
                    </div>
                </div>
                <div class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                    <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                        <span class="material-symbols-outlined">
                            local_police
                        </span>
                    </div>
                    <div class=" flex flex-col h-full">
                        <div class="font-semibold text-main  text-[20px]"> 
                            {{count.police}}
                        </div>
                        <div class="font-semibold text-gray-500  text-[13px]"> 
                           Law Enforcement
                        </div>
                    </div>
                </div>

                <div class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                    <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                        <span class="material-symbols-outlined">
                            search_insights
                        </span>
                    </div>
                    <div class=" flex flex-col h-full">
                        <div class="font-semibold text-main  text-[20px]"> 
                            {{count.forensic}}
                        </div>
                        <div class="font-semibold text-gray-500  text-[13px]"> 
                           Forensics
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

const count = ref({
    forensic : 0,
    police: 0,
    lawyers:0,
    prosecutors:0,
    judges:0
})

 const getCount =async ()=>{
    const {contract} = await getSignerContract();
    const number = await contract.countUsersByPosition()
    count.value.forensic = getNumber(number.forensicCount)
    count.value.police = getNumber(number.lawEnforcementCount)
    count.value.prosecutors = getNumber(number.prosecutorCount)
    count.value.judges = getNumber(number.judgeCount)
}

 onMounted(async()=>{
    await getCount();
 })

</script>