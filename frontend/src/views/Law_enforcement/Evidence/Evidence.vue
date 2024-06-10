<template>
    <div class="w-full h-full flex-col overflow-y-auto">
        <div class="w-full flex flex-row">
           
            <div class="text-center">
                <v-overlay v-model="evidenceOverlay">
                    <div  class="w-screen h-screen p-2 flex items-center justify-center">
                        <NewEvidenceForm @close="closeModal()"/>
                    </div>
                </v-overlay>
            </div>

            <div v-if="role == 'Law enforcement'" @click="evidenceOverlay = !evidenceOverlay" class="relative flex h-fit flex-row space-x-4 items-center mx-2 w-1/4 p-4 min-w-fit font-sans rounded-md bg-[#ebebeb] hover:bg-opacity-50 shadow-sm hover:shadow-md transition-all duration-100 ease-in ">
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
        </div>
        <div class="my-8">
            <div class="flex flex-col">
                <div class=" text-xl text-gray-800  mb-4 font-semibold tracking-tighter font-sans">
                    Recent files
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
                                photo
                            </span>
                        </div>
                        <div>
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">Image</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>224kb</div>
                                <div>jpeg</div>
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
                                photo
                            </span>
                        </div>
                        <div>
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">Image</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>224kb</div>
                                <div>jpeg</div>
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
                                photo
                            </span>
                        </div>
                        <div>
                            <div class="font-bold text-gray-700 font-sans tracking-tight ">Image</div>
                            <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                                <div>224kb</div>
                                <div>jpeg</div>
                            </div>
                        </div> 
                    </div>

                </div>

            </div>
        </div>

        <div class="w-full flex flex-col">
            <div class=" text-xl text-gray-800 font-semibold tracking-tighter font-sans mb-4">
                 All files
            </div>
            <div class="flex flex-row xl:w-[80%] md:w-full justify-between mb-3 ">
                <div class="w-[24%] h-fit mt-auto justify-between min-w-fit max-md:space-x-2 border border-gray-200 rounded-md bg-main3 flex flex-row font-bold tracking-tight text-sm px-4 py-[1px] items-center transition-all duration-300 ease-in-out">
                    <button @click="filterFiles('all')" :class="{'border bg-gray-50 text-gray-800':fileType.all}" class="text-gray-400 p-1 rounded-md">
                        View all
                    </button>
                    <button @click="filterFiles('images')" :class="{'border bg-gray-50 text-gray-800':fileType.images}" class="text-gray-400 p-1 rounded-md">images</button>
                    <button @click="filterFiles('videos')" :class="{'border bg-gray-50 text-gray-800':fileType.videos}" class="text-gray-400 p-1 rounded-md">videos</button>
                </div>
                <div class="w-1/4 ">
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
                fixed-header
                >
                    <thead>
                        <tr>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">File Name</span>
                            </th>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Uploaded By</span>
                            </th>
                            <th  style="background-color: #ebebeb;" class="text-left w-1/3">
                                <span class="text-md text-gray-600 font-bold">Last&nbsp;modified</span>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="flex flex-row items-center"> 
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
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            John J. Doe (Lawyer)
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                               </td>

                               <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificEvidenceOverlay = !specificEvidenceOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="flex flex-row items-center"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        videocam
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Video</div>
                                    <div class="flex flex-row space-x-2 font-sans font-medium text-gray-600">
                                        <div>224kb</div>
                                        <div>mp4</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            John J. Doe (Lawyer)
                                        </div>
                                        <div class="font-sans font-medium truncate overflow-hidden text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                               </td>

                               <td class="text-gray-600 font-sans">
                                    <div class="flex flex-row items-center space-x-4">
                                        <div>April 24, 2024</div>
                                        <button @click="specificEvidenceOverlay = !specificEvidenceOverlay" class="text-main font-bold hover:underline text-sm">
                                            View
                                        </button>
                                    </div>
                                </td>
                        </tr>
                        <tr>
                            <td class="flex flex-row items-center"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        article
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Pdf file</div>
                                    <div class="flex flex-row space-x-2 font-sans font-medium text-gray-600">
                                        <div>224kb</div>
                                        <div>pdf</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            John J. Doe (Lawyer)
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                            </td>

                            <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificEvidenceOverlay = !specificEvidenceOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>                        
                        </tr>
                        <tr>
                            <td class="flex flex-row items-center"> 
                                <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                    <span class="material-symbols-outlined">
                                        photo
                                    </span>
                                </div>
                                <div>
                                    <div class="font-bold text-gray-800">Image</div>
                                    <div class="flex flex-row space-x-2 font-sans font-medium text-gray-600">
                                        <div>224kb</div>
                                        <div>jpeg</div>
                                    </div>
                                </div> 
                            </td>
                            <td class="text-gray-600">
                                <div class="flex flex-row">
                                    <div class="">

                                    </div>
                                    <div class="flex flex-col">
                                        <div class="font-bold text-gray-800">
                                            John J. Doe (Lawyer)
                                        </div>
                                        <div class="font-sans font-medium text-ellipsis text-gray-600">0x1cC9B609187123a5d7b2D90a6985Acf15d43a2cb</div>
                                    </div>
                                </div>
                               </td>

                               <td class="text-gray-600 font-sans">
                                <div class="flex flex-row items-center space-x-4">
                                    <div>April 24, 2024</div>
                                    <button @click="specificEvidenceOverlay = !specificEvidenceOverlay" class="text-main font-bold hover:underline text-sm">
                                        View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <div class="text-center">
                            <v-overlay v-model="specificEvidenceOverlay">
                                <div @click="specificEvidenceOverlay = !specificEvidenceOverlay"  class="w-screen h-screen p-2 flex items-center justify-center">
                                    <SpecificEvidenceView @close="specificEvidenceOverlay = !specificEvidenceOverlay"/>
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
    import {onMounted, ref} from "vue"
    import NewEvidenceForm from "./NewEvidenceForm.vue";
    import SpecificEvidenceView from "./SpecificEvidence.vue"
    import { getState } from "@/utils/contractService";

    const role = ref('')

    onMounted(()=>{
        role.value = getState('role') 
    })

    const evidenceOverlay = ref(false)
    const specificEvidenceOverlay = ref(false)

    const search = ref(null)
    const fileType = ref({
        all:true,
        images:false,
        videos:false
    })

    const getEvidences = ()=>{
        console.log('hahaha');
    }

    const filterFiles = (key) => {
        fileType.value.all=false; fileType.value.images=false; fileType.value.videos=false; 
        if (Object.prototype.hasOwnProperty.call(fileType.value, key)) {
            fileType.value[key] = true;
        }
    };
    const closeModal = ()=>{
        evidenceOverlay.value = !evidenceOverlay.value
        setTimeout(() => {
            getEvidences();
        }, 20000);
    }

    
</script>

