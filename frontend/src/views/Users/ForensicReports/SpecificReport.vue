<template>
    <div @click.stop="" class="w-2/3 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 overflow-y-auto bg-gray-50 rounded-lg mx-auto">
        <div class="w-3/4 flex justify-start mx-auto mt-4">
           <v-btn prepend-icon="mdi-arrow-left" size="small" @click="close()" variant="outlined" color="red">back</v-btn>
        </div>
       <div v-if="!isLoading" v-motion-fade class="w-3/4 h-full mx-auto py-8  p-4 flex flex-col">
        <div class="flex flex-row ">
            <div class="text-2xl text-gray-700 font-semibold tracking-tighter font-sans">
               Report&nbsp;{{ oneReport.item_Number }}
           </div>
           <!-- <v-btn :prepend-icon="maximize?'mdi-menu-up':'mdi-menu-down'" @click="maximize=!maximize" class="ml-auto" color="main" size="small" variant="outlined"><div class="font-bold">{{maximize?'minimize':'View item'}}</div> </v-btn> -->

        </div>
           
           <div class="flex flex-row space-x-1 items-center">
               <!-- <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01253d</div> -->
               <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                   <div>{{oneReport.evidence_description}}</div>
               </div>
               
               <div class="flex flex-row space-x-2 text-sm font-[550] text-main">
                   <div>added by {{forensic.name}},&nbsp;{{forensic.address}}</div>
               </div>
           </div> 
           <div class="h-fit transition-all duration-700 ease-in-out">
            <iframe
                :src="getFileUrl()"
                class="w-full h-[600px] border-none mb-5 aspect-w-16 aspect-h-9"
                frameborder="0"
                allowfullscreen
            ></iframe>
           </div>

       </div>
       <div v-if="isLoading" v-motion-fade class="w-3/4 h-full mx-auto py-8  p-4 flex flex-col">
            <loader/>
       </div>
    </div>       
</template>

<script setup>
import {ref, onMounted} from "vue" 
import { getObjectState,getState,getSignerContract } from "@/utils/contractService";
import loader from "@/components/Loader.vue"

const {oneReport} = defineProps(['oneReport'])
const role = ref('')
const isLoading = ref(true);
const forensic = ref([])

onMounted(async()=>{
    role.value = getState('role')
    forensic.value = getObjectState('forensic'); 
    //await getUserDetails();
    isLoading.value = false;
})

const addedBy = ref([])

const getFileUrl = ()=>{
    return import.meta.env.VITE_APP_PINATA_GATEWAY + oneReport.file_hash
}

const getUserDetails = async ()=>{
    const {contract} = await getSignerContract()
    addedBy.value = await contract.login(oneReport.writer)
}

const emit = defineEmits(["close"]);

const close = ()=>{
    emit('close')
}
</script>