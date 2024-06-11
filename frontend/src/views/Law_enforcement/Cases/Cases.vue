<template>
    <div class="w-full h-full flex-col overflow-y-auto">
        <div class="w-full flex flex-row">

            <div v-if="role == 'Prosecutor'" @click="caseOverlay = !caseOverlay" class="relative flex h-fit flex-row space-x-4 items-center cursor-pointer mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                <div class="absolute top-1 right-1 text-gray-400">
                    <span class="material-symbols-outlined text-[19px]">
                        add
                    </span>
                </div>
                <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                    <span class="material-symbols-outlined">
                        inventory_2
                    </span>
                </div>
                <div class="font-semibold text-gray-700  text-[14px]"> 
                     New case
                </div>
            </div>
           
            <div class="text-center">
                <v-overlay v-model="caseOverlay">
                    <div @click="caseOverlay = !caseOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                        <NewCaseForm @close="closeModal()"/>
                    </div>
                </v-overlay>
            </div>
         
        </div>
        <div class="my-8">
            <div class="flex flex-col">
                <div class=" text-xl text-gray-800  mb-4 font-semibold tracking-tighter font-sans">
                    Recently Modified
                </div>
                <div  class="flex flex-row xl:w-[80%] md:w-full justify-between">
                    <div v-for="oneCase in recentlyAddedCases" :key="oneCase.case_no" class="relative w-[30%] mr-2 min-w-fit flex flex-row items-center border-[0.5px] border-gray-300 rounded-md p-2 shadow"> 
                        <div class="absolute top-1 right-1 text-gray-400">
                            <span class="material-symbols-outlined">
                                more_vert
                            </span>
                        </div>
                        <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center ">
                            <span class="material-symbols-outlined">
                                gavel
                            </span>
                        </div>
                        <div>
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">{{oneCase.case_no}}</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>{{oneCase.case_description}}</div>
                                
                            </div>
                        </div> 
                    </div>
                
            

                </div>

            </div>
        </div>

        <div class="w-full flex flex-col">
            <div class=" text-xl text-gray-800 font-semibold tracking-tighter font-sans mb-4">
                 My Cases
            </div>
            <div class="flex flex-row xl:w-[80%] md:w-full justify-between mb-3 ">
               
                <div class="w-1/4">
                    <v-text-field
                        :disabled="! cases.length > 0"
                        density="compact"
                        class="h-1/2 text-caption font-weight-bold font-sans"
                        width="50%"
                        v-model="search"
                        label="Search"
                        prepend-inner-icon="mdi-magnify"
                        variant="solo-filled"
                        flat
                        hide-details
                        single-line
                    ></v-text-field>
                </div>
            </div>
            <div class="xl:w-[80%] md:w-full mr-auto">
                <v-table
                height="100%"
                width="75%"
                variant="comfortable"
                fixed-header
                >
                    <thead>
                        <tr>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Case</span>
                            </th>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Added By</span>
                            </th>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Last&nbsp;modified</span>
                            </th>
                        </tr>
                    </thead>
                    <tbody >
                        <tr v-for="(oneCase,index) in displayedCases" :key="oneCase.case_no" class="h-fit">
                            <td class="flex flex-row items-center h-full"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        gavel
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">{{ oneCase.case_no }}</div>
                                    <div class="flex flex-col space-x-2 font-sans font-medium text-gray-600">
                                        <div>{{oneCase.case_description}}</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            {{  (userDetails.length>0)?userDetails[index][0]:'' }}<span class="text-gray-600">&nbsp;({{ (userDetails.length>0)?userDetails[index][1]:'' }})</span> 
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">{{ oneCase.addedBy }}</div>
                                    </div>
                                </div>
                            </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>{{ getDate(oneCase.dateAdded) }}</div>
                                    <div class="text-main" title="view">
                                        <v-btn @click="viewCase(oneCase)" density="comfortable" variant="text" icon="mdi-eye" size="medium"></v-btn>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr v-if="!cases.length > 0">
                            <td class="flex mx-auto font-sans font-medium text-gray-600 items-center">NO CASES</td>
                        </tr>
                     
        
                       
                        <div v-if="specificCaseOverlay" class="text-center">
                            <v-overlay v-model="specificCaseOverlay">
                                <div @click="specificCaseOverlay = !specificCaseOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                                    <SpecificCaseView :oneCase="viewedCase" @close="specificCaseOverlay = !specificCaseOverlay"/>
                                </div>
                            </v-overlay>
                        </div>
                    </tbody>
                </v-table>
            </div>
        </div>
        
    </div>
</template>

<script setup>
    import {ref, onMounted, watch} from "vue"
    import NewCaseForm from "./NewCaseForm.vue";
    import SpecificCaseView from "../Cases/SpecificCase.vue"
    import { getState, getSignerContract, getDate } from "@/utils/contractService";


    const role = ref('')

    const cases = ref([]);
    const displayedCases = ref([])
    const recentlyAddedCases = ref([]) //last three added cases

    //users that have added the cases
    const userDetails = ref([]);

    const viewedCase = ref([])

    const getMyCases = async ()=>{
        const {signer,contract} = await getSignerContract()
        cases.value = await contract.getmyCase(signer.getAddress());
        displayedCases.value = cases.value
        const numberOfCases = cases.value.length;
        if(numberOfCases>=3){
            recentlyAddedCases.value[0]=cases.value[length-1]
            recentlyAddedCases.value[1]=cases.value[length-2]
            recentlyAddedCases.value[2]=cases.value[length-3]
        }
        else if(numberOfCases>0 && numberOfCases<3){
            cases.value.forEach((oneCase,index) => recentlyAddedCases.value[index] = oneCase)
        }
    }

    const getUserDetails = async ()=>{
        const {contract} = await getSignerContract()
        cases.value.forEach(async (oneCase,index) => userDetails.value[index] =  await contract.login(oneCase.addedBy))
    }


    onMounted(async ()=>{
        role.value = getState('role') 
        await getMyCases();
        getUserDetails();
    })

    const caseOverlay = ref(false)
    const specificCaseOverlay = ref(false)

    const search = ref(null)

    watch(search, ()=>{
        displayedCases.value = cases.value.filter(oneCase =>{
            if(search.value){
                return  oneCase.case_no.toLowerCase().includes(search.value.toLowerCase())
            }
            else return oneCase;
        });
    })

    const fileType = ref({
        all:true,
        pdf:false,
        images:false,
        videos:false
    })

    const filterFiles = (key) => {
        fileType.value.all=false; fileType.value.pdf=false; fileType.value.images=false; fileType.value.videos=false; 
        if (Object.prototype.hasOwnProperty.call(fileType.value, key)) {
            fileType.value[key] = true;
        }
    };

    const viewCase= (oneCase)=>{
        viewedCase.value = oneCase;
        specificCaseOverlay.value = !specificCaseOverlay.value
    }

    const closeModal = ()=>{
        caseOverlay.value = !caseOverlay.value
        setTimeout(() => {
            getMyCases();
        }, 20000);
    }
</script>

