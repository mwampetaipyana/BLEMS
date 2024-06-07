<template>
    <div @click.stop="" class="w-1/2 max-md:w-[96%] max-md:h-full min-w-fit h-3/4 bg-gray-50 rounded-lg mx-auto">
        <div class="w-3/4 h-full mx-auto py-8 p-4 flex flex-col">
            <div class="text-2xl text-gray-800 font-semibold tracking-tighter font-sans">
                Case Details
            </div> 
            <form class="h-[90%] flex flex-col justify-between my-4 font-sans text-sm transition-all duration-500 ease-in overflow-y-auto" >
                <div class="w-full flex flex-col ">
                    <v-text-field
                    v-model="state.caseNo"
                    :error-messages="v$.caseNo.$errors.map(e => e.$message)"
                    label="Case number"
                    required
                    @blur="v$.caseNo.$touch"
                    @input="v$.caseNo.$touch"
                    ></v-text-field>

                    <v-text-field
                    v-model="state.description"
                    :counter="100"
                    :error-messages="v$.description.$errors.map(e => e.$message)"
                    label="Description"
                    required
                    @blur="v$.description.$touch"
                    @input="v$.description.$touch"
                    ></v-text-field>

                    <div class="w-full flex justify-between items-center">
                        <div class="w-1/2">
                            <v-checkbox v-model="state.addPersons"
                            label="Add Involved legal Participants"
                            ></v-checkbox>
                        </div>
                        <div class="w-1/2">
                            <v-text-field
                            density="compact"
                            class=" ml-auto"
                            :class="{'blur pointer-events-none':!state.addPersons}"
                            v-model="state.noOFPersons"
                            :error-messages="v$.noOFPersons.$errors.map(e => e.$message)"
                            label="Number of Invloved Persons"
                            required
                            @blur="v$.noOFPersons.$touch"
                            @input="v$.noOFPersons.$touch"
                            ></v-text-field>
                        </div>
                    </div>
                               
                    <div v-if="state.addPersons" class="w-full">
                        <div  v-for="n in Number(state.noOFPersons)" :key="n" class="w-full px-4 flex space-x-4 ">
                            <div  class="w-1/2">
                                <v-text-field
                                v-model="state.participants[n-1]"
                                :error-messages="v$.participants.$errors.map(e => e.$message)"
                                label="Participant Address"
                                required
                                @blur="v$.participants.$touch"
                                @input="v$.participants.$touch"
                                ></v-text-field>
                            </div>
                            <div v-if="state.participants[n]" class="bg-[#30564b] bg-opacity-10 rounded-full flex px-3 h-[30px] items-center my-auto font-sans text-sm font-medium">
                                Jane D. Doe <span class="text-gray-600">(Lawyer)</span> 
                            </div>
                        </div>
                    </div>
                    
                </div>
               

                <div class="w-full flex justify-between">
                    <v-btn
                        class="text-none"
                        color="red"
                        min-width="92"
                        variant="outlined"
                        rounded
                        @click="close()"
                    >
                        Close
                    </v-btn>

                    <v-btn
                        class="text-none"
                        color="main"
                        min-width="92"
                        rounded
                        @click="addNewCase()"
                    >
                        <div class="font-sans">Submit</div>
                    </v-btn>
                </div>
            </form>
        </div>
    </div>
</template>

<script setup>
    import { ref } from 'vue'
    import { useVuelidate } from '@vuelidate/core'
    import { integer, required } from '@vuelidate/validators'
    import { getSignerContract } from '@/utils/contractService';

    const initialState = {
        caseNo: '',
        description: '',
        noOFPersons:0,
        addPersons:false,
        participants:[]
    }

    const state = ref({
        ...initialState,
    })

    const items = [
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
    ]

    const rules = {
        caseNo: { required },
        description: { required },
        noOFPersons:{integer, required},
        participants:{required}
    }

    const v$ = useVuelidate(rules, state)

    const clear = () => {
        v$.value.$reset()

        for (const [key, value] of Object.entries(initialState)) {
         state[key] = value
        }
    }

    const emit = defineEmits(["close"]);

    const close = ()=>{
        emit('close')
    }
/*
    string memory _caseNo,
        string memory _caseDescription,
        uint256 _noParticipants,
        address[] memory _participants
*/ 
    const addNewCase = async()=>{
        const {contract} = await getSignerContract()
        console.log(state.value.participants[0]);
        await contract.addNewCase(state.value.caseNo, state.value.description, state.value.noOFPersons, state.value.participants);
        close()
    }
   
</script>