<template>
    <div @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 bg-gray-50 rounded-lg mx-auto">
       <div class="w-3/4 h-full mx-auto py-8 p-4 flex flex-col">
        <div class="flex flex-row ">
            <div class="text-2xl text-gray-700 font-semibold tracking-tighter font-sans">
               Item 01253d
           </div>

            <v-btn class="ml-auto" color="main" size="small" variant="outlined"><div class="font-bold">View</div> </v-btn>
        </div>
           
           <div class="flex flex-row space-x-1 items-center">
               <!-- <div class="font-bold text-gray-700 font-sans tracking-tight ">Case 01253d</div> -->
               <div class="flex flex-row space-x-2 text-sm font-[550] text-gray-600">
                   <div>Image of suspect in crime scene</div>
               </div>
               
               <div class="flex flex-row space-x-2 text-sm font-[550] text-main">
                   <div>added by Judge, Jane J. Doe</div>
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
                                    Attached Reports
                               </div>
                               <v-btn v-if="role == 'Forensic'"  color="main"><div class="text-white">Add</div></v-btn>
                           </th>
                  
                       </tr>
                   </thead>

                   <tbody>
                       <tr>
                           <td class="flex flex-row items-center justify-between">
                               <div class="flex flex-row items-center">
                                   <div class="bg-gray-200 h-10 w-10 rounded-md mr-2 flex items-center justify-center">
                                       <span class="material-symbols-outlined">
                                        article
                                       </span>
                                   </div>
                                   <div>
                                       <div class="font-bold text-gray-800">Forensics report on Evidence</div>
                                       <div class="flex font-sans font-medium text-gray-600">
                                           <div>Inconclusive</div>
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
                                   <div>
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
</template>

<script setup>
import {ref, onMounted} from "vue" 
import { getState } from "@/utils/contractService";

const role = ref('')

onMounted(()=>{
    role.value = getState('role') 
})

</script>