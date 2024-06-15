<template>
    <div class="w-full flex flex-col">
            
            <div class="flex flex-row xl:w-[80%] md:w-full justify-between mb-3 ">
               
                <div class="w-1/4">
                    <v-text-field
                        density="compact"
                        class="h-1/2 text-caption font-weight-bold font-sans"
                        width="50%"
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
                                   
                                </div>
                            </td>
                        </tr>
                       
                    </tbody>
                </v-table>
            </div>
        </div>    
</template>