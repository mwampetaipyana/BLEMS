<template>
     <div v-if="!newEvidenceOverlay && !oneEvidenceOverlay && !newReportOverlay" @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 bg-gray-50 rounded-lg mx-auto">
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
                                <v-btn v-if="role == 'prosecutor'" color="main"><div class="text-white">Add</div></v-btn>

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
                        <tr v-if="!oneCase.participants.length > 0">
                            <td class="flex mx-auto font-sans font-medium text-gray-600 items-center">NO PARTICIPANTS</td>
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
                                <v-btn @click="newEvidenceOverlay=!newEvidenceOverlay" v-if="role == 'police'"  color="main"><div class="text-white">Add</div></v-btn>

                            </th>
                   
                        </tr>
                    </thead>

                    <tbody>
                        <tr v-for="(evidence,index) in evidences" :key="evidence.item_Number">
                            <td class="flex flex-row items-center justify-between">
                                <div class="flex flex-row items-center">
                                    <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                        <span class="material-symbols-outlined">
                                            photo
                                        </span>
                                    </div>
                                    <div>
                                        <div class="font-bold text-gray-800">item&nbsp;{{evidence.item_Number}}</div>
                                        <div class="flex flex-row space-x-2 font-sans font-medium text-gray-600">
                                            <div>{{evidence.evidence_description}}</div>
                                        </div>
                                    </div> 
                                </div> 
                                <div class="flex flex-row items-center space-x-4">
                                    <div class="flex flex-col max-md:flex-col text-sm mt-1">
                                        <div class="font-bold text-gray-800">
                                            Uploaded by {{(evidenceUploaders.length>0)?evidenceUploaders[index][0]:''}}<span class="text-gray-600">&nbsp;({{(evidenceUploaders.length>0)?evidenceUploaders[index][1]:''}})&nbsp;</span> 
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-main">{{evidence.collector}}</div>
                                    </div>
                                    <div class="text-blue-600" title="view">
                                        <v-btn @click="viewEvidence(evidence)" class="text-blue-600" density="comfortable" variant="text" icon="mdi-eye" size="small"></v-btn>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr v-if="!evidences.length > 0">
                            <td class="flex mx-auto font-sans font-medium text-gray-600 items-center">NO UPLOADED EVIDENCES</td>
                        </tr>
                    </tbody>
            </v-table>

            <v-table
               class="mt-8"
               height="100%"
               width="75%"
               fixed-header
               >
                   <thead>
                       <tr>
                           <th  style="background-color: #ebebeb;" class="text-left w-full flex items-center flex-row justify-between">
                               <div class="text-lg text-gray-700 font-semibold tracking-tighter font-sans">
                                    Attached Reports
                               </div>
                               <v-btn @click="newReportOverlay=!newReportOverlay" v-if="role == 'Forensic'"  color="main"><div class="text-white">Add</div></v-btn>
                           </th>
                  
                       </tr>
                   </thead>

                   <tbody>
                       <tr v-for="report in reports" :key="report">
                           <td class="flex flex-row items-center justify-between">
                               <div class="flex flex-row items-center">
                                   <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                       <span class="material-symbols-outlined">
                                        article
                                       </span>
                                   </div>
                                   <div>
                                       <div class="font-bold text-gray-800">{{report.title}}</div>
                                       <div class="flex font-sans font-medium text-gray-600">
                                           <div>{{report.description}}</div>
                                       </div>
                                   </div> 
                               </div> 
                               <div class="flex flex-row items-center space-x-4">
                                   <div class="flex flex-col max-md:flex-col text-sm mt-1">
                                       <div class="font-bold text-gray-800">
                                           Uploaded by Jojo J. Doe<span class="text-gray-600">&nbsp;(Forensics)&nbsp;</span> 
                                       </div>
                                       <div class="font-sans font-medium text-ellipsis text-main">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                   </div>
                                   <div class="text-blue-600" title="view">
                                        <v-btn class="text-blue-600" density="comfortable" variant="text" icon="mdi-eye" size="small"></v-btn>
                                   </div>
                               </div>
                           </td>
                       </tr>
                       <tr v-if="!reports.length > 0">
                            <td class="flex font-sans font-medium text-gray-600 items-center">NO REPORTS</td>
                        </tr>
                   </tbody>
           </v-table>
        </div>
     </div> 
     <NewEvidenceFormView v-if="newEvidenceOverlay" :case_no="oneCase.case_no" @close="closeModals()"/>
     <SpecificEvidenceView v-if="oneEvidenceOverlay" :one-evidence="viewedEvidence"  @close="oneEvidenceOverlay=!oneEvidenceOverlay"/>      
     <NewReportView v-if="newReportOverlay" :case_no="oneCase.case_no" @close="closeModals()" /> 
</template>

<script setup>
import {ref, onMounted} from "vue" 
import { getState,getSignerContract } from "@/utils/contractService";
import NewEvidenceFormView from "../Evidence/NewEvidenceForm.vue";
import SpecificEvidenceView from "../Evidence/SpecificEvidence.vue";
import NewReportView from "../ForensicReports/NewReportForm.vue"

const role = ref('')
const {oneCase} = defineProps(['oneCase'])
const legalParticipants = ref([])
const evidenceUploaders = ref([])
const AddedBy = ref([])
const evidences = ref([])
const reports = ref([])

const newEvidenceOverlay = ref(false)
const oneEvidenceOverlay = ref(false)
const newReportOverlay = ref(false)

const viewedEvidence = ref([])

onMounted(()=>{
    role.value = getState('role') 
    getUserDetails()
    getEvidences()
    getReports()
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
    evidences.value.forEach(async (evidence,index) => evidenceUploaders.value[index] =  await contract.login(evidence.collector))
    console.log(evidences.value);
    console.log(evidenceUploaders.value);
}


const viewEvidence = (evidence)=>{
    viewedEvidence.value = evidence
    oneEvidenceOverlay.value = true
}

const getReports = async ()=>{
    const {contract} = await getSignerContract()
    reports.value = await contract.getReport(oneCase.case_no)
    console.log(reports.value);
}
    const closeModals = ()=>{
        newReportOverlay.value = false
        newEvidenceOverlay.value = false
        setTimeout(() => {
            getMyCases();
            getEvidences();
        }, 20000);
    }


</script>
