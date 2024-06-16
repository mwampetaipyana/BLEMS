<template>
    <div @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 overflow-y-auto bg-gray-50 rounded-lg mx-auto">
        <div class="w-3/4 flex justify-start mx-auto mt-4">
           <v-btn prepend-icon="mdi-arrow-left" size="small" @click="close()" variant="outlined" color="red">back</v-btn>
        </div>
       <div v-if="!isLoading" v-motion-fade class="w-3/4 h-full mx-auto py-8  p-4 flex flex-col">
        <div class="flex flex-row ">
            <div class="text-2xl text-gray-700 font-semibold tracking-tighter font-sans">
               Item&nbsp;{{ oneEvidence.item_Number }}
           </div>
         <v-btn v-if="role=='forensic'" @click="downloadFile()" prepend-icon="mdi-download"  class="ml-auto" color="main" size="small" variant="outlined">Download</v-btn>

        </div>
           
           <div class="flex flex-row space-x-1 items-center">
               <!-- <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01253d</div> -->
               <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                   <div>{{oneEvidence.evidence_description}}</div>
               </div>
               
               <div class="flex flex-row space-x-2 text-sm font-[550] text-main">
                   <div>added by {{addedBy[0]}},&nbsp;{{addedBy[1]}}</div>
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
import { getState,getSignerContract } from "@/utils/contractService";
import loader from "@/components/Loader.vue"

const {oneEvidence} = defineProps(['oneEvidence'])
const role = ref('')
const isLoading = ref(true)

onMounted(async()=>{
    role.value = getState('role') 
    await getUserDetails();
    isLoading.value = false;
})

const addedBy = ref([])

const getFileUrl = ()=>{
    return import.meta.env.VITE_APP_PINATA_GATEWAY + oneEvidence.evidenceCID
}

const getUserDetails = async ()=>{
    const {contract} = await getSignerContract()
    addedBy.value = await contract.login(oneEvidence.collector)
}



const emit = defineEmits(["close"]);

const close = ()=>{
    emit('close')
}

const downloadFile = async()=> {
    try {
    const response = await fetch(getFileUrl()); 
    if (!response.ok) {
        throw new Error(`Failed to fetch file from Pinata (status: ${response.status})`);
    }
    const blob = await response.blob();
    const contentType = response.headers.get('content-type');
    const extension = getExtensionFromContentType(contentType) || 'jpg'; // jpg is default extension

    const url = URL.createObjectURL(blob);

    const link = document.createElement('a');
    link.href = url;
    link.download = `image.${extension}`;
    link.click();

    URL.revokeObjectURL(url);
    } catch (error) {
        console.error("Error downloading File:", error);
    }
}

const getExtensionFromContentType = (contentType)=>{
  if (!contentType) return null;
  return contentType.split('/')[1];
}

</script>