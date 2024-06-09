<template>
     <div v-if="!evidenceOverlay" @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 bg-gray-50 rounded-lg mx-auto">
        <div class="w-3/4 h-full mx-auto py-8 p-4 flex flex-col">
            <div class="text-2xl text-gray-700 font-semibold tracking-tighter font-sans">
                Case&nbsp;{{oneCase.case_no}}
            </div>
            <div class="flex flex-row space-x-1">
                <!-- <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01253d</div> -->
                <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                    <div>{{oneCase.case_description}},</div>
                </div>
                
                <div class="flex flex-row space-x-2 text-sm font-[550] text-main">
                    <div>added by {{AddedBy[0]}}, {{AddedBy[1]}}</div>
                </div>
            </div> 
            <v-table
                class="mt-12"
                height="100%"
                width="75%"
                fixed-header
                >
                    <thead>
                        <tr>
                            <th  style="background-color: #ebebeb;" class="text-left w-full flex items-center flex-row justify-between">
                                <div class="text-lg text-gray-700 font-semibold tracking-tighter font-sans">
                                    Legal Participants
                                </div>
                                <v-btn v-if="role == 'Prosecutor'" color="main"><div class="text-white">Add</div></v-btn>

                            </th>
                   
                        </tr>
                    </thead>

                    <tbody>
                        <tr v-for="(participant,index) in oneCase.participants" :key="index">
                            <td >
                                <div class="flex flex-row md:justify-between max-md:flex-col text-sm mt-1">
                                    <div class="font-bold text-gray-800">
                                       {{(legalParticipants.length>0)?legalParticipants[index][0]:''}}<span class="text-gray-600">&nbsp;({{(legalParticipants.length>0)?legalParticipants[index][1]:''}})&nbsp;</span> 
                                    </div>
                                    <div class="font-sans font-medium text-ellipsis text-main">{{ participant }}</div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
            </v-table>
            <v-table
                class="mt-12"
                height="100%"
                width="75%"
                fixed-header
                >
                    <thead>
                        <tr>
                            <th  style="background-color: #ebebeb;" class="text-left w-full flex items-center flex-row justify-between">
                                <div class="text-lg text-gray-700 font-semibold tracking-tighter font-sans">
                                    Applied Evidences
                                </div>
                                <v-btn @click="evidenceOverlay=!evidenceOverlay" v-if="role == 'Law enforcement'"  color="main"><div class="text-white">Add</div></v-btn>

                            </th>
                   
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td class="flex flex-row items-center justify-between">
                                <div class="flex flex-row items-center">
                                    <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                        <span class="material-symbols-outlined">
                                            photo
                                        </span>
                                    </div>
                                    <div>
                                        <div class="font-bold text-gray-800">Image</div>
                                        <div class="flex flex-row space-x-2 font-sans font-medium text-gray-600">
                                            <div>224kb</div>
                                            <div>png</div>
                                        </div>
                                    </div> 
                                </div> 
                                <div class="flex flex-row items-center space-x-4">
                                    <div class="flex flex-col max-md:flex-col text-sm mt-1">
                                        <div class="font-bold text-gray-800">
                                            Uploaded by Jojo J. Doe<span class="text-gray-600">&nbsp;(Police Officer)&nbsp;</span> 
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-main">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                    <div >
                                        <button class="text-blue-600 font-bold hover:underline text-sm">
                                            View
                                        </button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
            </v-table>

         
           
        </div>
     </div> 
     <NewEvidenceFormView v-if="evidenceOverlay" :case_no="oneCase.case_no" @close="evidenceOverlay=!evidenceOverlay"/>      
</template>

<script setup>
import {ref, onMounted} from "vue" 
import { getState,getSignerContract } from "@/utils/contractService";
import NewEvidenceFormView from "../Evidence/NewEvidenceForm.vue";

const role = ref('')
const {oneCase} = defineProps(['oneCase'])
const legalParticipants = ref([])
const AddedBy = ref([])
const evidences = ref([])

const evidenceOverlay = ref(false)

onMounted(()=>{
    role.value = getState('role') 
    getUserDetails()
    getEvidences()
    console.log(oneCase);
})

const getUserDetails = async ()=>{
    const {contract} = await getSignerContract()
    oneCase.participants.forEach(async (participant,index) => legalParticipants.value[index] =  await contract.login(participant))
    AddedBy.value = await contract.login(oneCase.addedBy)
}


const getEvidences = async ()=>{
    const {contract} = await getSignerContract()
    evidences.value = await contract.getEvidence(oneCase.case_no)
    console.log(evidences.value);
}

</script>
