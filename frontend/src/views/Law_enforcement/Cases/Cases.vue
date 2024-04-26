<template>
    <div class="w-full h-full flex-col overflow-y-auto">
        <div class="w-full flex flex-row">
            <div @click="caseOverlay = !caseOverlay" class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
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
            <div @click="evidenceOverlay = !evidenceOverlay" class="relative flex h-fit flex-row space-x-4 items-center w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
                <div class="absolute top-1 right-1 text-gray-400">
                    <span class="material-symbols-outlined text-[19px]">
                        add
                    </span>
                </div>
                <div class="bg-gray-700 rounded text-gray-300 h-10 w-10 flex items-center justify-center">
                    <span class="material-symbols-outlined">
                        description
                    </span>
                </div>
                <div class="font-semibold text-gray-700  text-[14px]"> 
                    New evidence
                </div>
            </div>
            <div class="text-center">
                <v-overlay v-model="caseOverlay">
                    <div @click="caseOverlay = !caseOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                        <NewCaseForm @close="caseOverlay = !caseOverlay"/>
                    </div>
                </v-overlay>
            </div>
            <div class="text-center">
                <v-overlay v-model="evidenceOverlay">
                    <div @click="evidenceOverlay = !evidenceOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                        <newEvidenceForm @close="evidenceOverlay = !evidenceOverlay"/>
                    </div>
                </v-overlay>
            </div>
         
        </div>
        <div class="my-8">
            <div class="flex flex-col">
                <div class=" text-xl text-gray-800  mb-4 font-semibold tracking-tighter font-sans">
                    Recently Modified
                </div>
                <div class="flex flex-row xl:w-[80%] md:w-full justify-between">
                    <div class="relative w-[30%] mr-2 min-w-fit flex flex-row items-center border-[0.5px] border-gray-300 rounded-md p-2 shadow"> 
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
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01253d</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>Mr.Pablo against Mr.Escobar</div>
                                
                            </div>
                        </div> 
                    </div>
                    <div class="relative w-[30%] mr-2 min-w-fit flex flex-row items-center border-[0.5px] border-gray-300 rounded-md p-2 shadow"> 
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
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01253d</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>Mr.Pablo against Mr.Escobar</div>
                                
                            </div>
                        </div> 
                    </div>
                    <div class="relative w-[30%] min-w-fit flex flex-row items-center border-[0.5px] border-gray-300 rounded-md p-2 shadow"> 
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
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01153e</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>Mr.Pablo against Mr.Escobar</div>
                                
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
                    <tbody>
                        <tr class="h-fit">
                            <td class="flex flex-row items-center h-full"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        gavel
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Case 01223e</div>
                                    <div class="flex flex-col space-x-2 font-sans font-medium text-gray-600">
                                        <div>Mr.Pablo against the United Republic of Tanzania</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            Julie J. Doe<span class="text-gray-600">&nbsp;(Judge)</span> 
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                            </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificCaseOverlay = !specificCaseOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="flex flex-row items-center"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        gavel
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Case 01223e</div>
                                    <div class="flex flex-col space-x-2 font-sans font-medium text-gray-600">
                                        <div>Mr.Pablo against Mr.Escobar</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            Julie J. Doe<span class="text-gray-600">&nbsp;(Judge)</span> 
                                        </div>
                                        <div class="font-sans font-medium max-md:truncate text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                               </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificCaseOverlay = !specificCaseOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="flex flex-row items-center"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        gavel
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Case 01223e</div>
                                    <div class="flex flex-col space-x-2 font-sans font-medium text-gray-600">
                                        <div>Mr.Pablo against Mr.Escobar</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            Julie J. Doe<span class="text-gray-600">&nbsp;(Judge)</span> 
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                               </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificCaseOverlay = !specificCaseOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="flex flex-row items-center"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        gavel
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Case 01223e</div>
                                    <div class="flex flex-col space-x-2 font-sans font-medium text-gray-600">
                                        <div>The United Republic of Tanzania against Mr.Pablo</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            Julie J. Doe<span class="text-gray-600">&nbsp;(Judge)</span> 
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                               </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificCaseOverlay = !specificCaseOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <div class="text-center">
                            <v-overlay v-model="specificCaseOverlay">
                                <div @click="specificCaseOverlay = !specificCaseOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                                    <SpecificCaseView @close="specificCaseOverlay = !specificCaseOverlay"/>
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
    import {ref} from "vue"
    import NewCaseForm from "./NewCaseForm.vue";
    import NewEvidenceForm from "../Evidence/NewEvidenceForm.vue"
    import SpecificCaseView from "../Cases/SpecificCase.vue"

    const evidenceOverlay = ref(false)
    const caseOverlay = ref(false)
    const specificCaseOverlay = ref(false)
    const search = ref(null)

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
</script>

