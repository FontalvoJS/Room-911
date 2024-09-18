<template>
    <div class="container d-flex justify-content-center align-items-center mt-5">
        <div class="login-card">
            <div class="card-header">
                <h3 style="font-weight: bold">
                    Log in to Room 911
                    <span :class="{
                        'text-unlocked shake-effect': form.success,
                        'text-dark': !form.success,
                    }" style="float: right"><i :class="{
                        'fas fa-unlock': form.success,
                        'fas fa-lock': !form.success,
                    }"></i></span>
                </h3>
            </div>

            <div class="card-body">
                <form @submit.prevent="submitForm">
                    <div class="form-group mb-3">
                        <label for="employee_id" class="form-label">Your ID access</label>
                        <input id="employee_id" v-model="form.employee_id" type="password" class="form-control"
                            autofocus required />
                        <div v-if="errors.employee_id" class="text-danger">
                            <span v-for="(error, index) in errors.employee_id" :key="index">
                                {{ error }}</span>
                        </div>
                    </div>

                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-dark btn-block w-100 text-uppercase"
                            style="font-weight: bold">
                            Verify
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
<script>
import { useThrottle } from "../methods/useThrottle";
import { submitForm } from "../methods/room_methods";
export default {
    name: "RoomComponent",
    data() {
        return {
            form: {
                employee_id: this.id,
                success: false,
            },
            errors: {},
        };
    },
    props: {
        id: String,
    },
    methods: {
        submitForm: useThrottle(submitForm, 1000),
    },
};
</script>
<style scoped src="/resources/css/app.css"></style>
