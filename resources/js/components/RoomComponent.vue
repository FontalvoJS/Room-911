<template>
    <div
        class="container d-flex justify-content-center align-items-center mt-5"
    >
        <div class="login-card">
            <div class="card-header">
                <h3 style="font-weight: bold">
                    Log in to Room 911
                    <span
                        :class="{
                            'text-unlocked shake-effect': form.success,
                            'text-dark': !form.success,
                        }"
                        style="float: right"
                        ><i
                            :class="{
                                'fas fa-unlock': form.success,
                                'fas fa-lock': !form.success,
                            }"
                        ></i
                    ></span>
                </h3>
            </div>

            <div class="card-body">
                <form @submit.prevent="submitForm">
                    <div class="form-group mb-3">
                        <label for="employee_id" class="form-label"
                            >Your ID access</label
                        >
                        <input
                            id="employee_id"
                            v-model="form.employee_id"
                            type="password"
                            class="form-control"
                            autofocus
                            required
                        />
                        <div v-if="errors.employee_id" class="text-danger">
                            <span
                                v-for="(error, index) in errors.employee_id"
                                :key="index"
                            >
                                {{ error }}</span
                            >
                        </div>
                    </div>

                    <div class="form-group text-center">
                        <button
                            type="submit"
                            class="btn btn-dark btn-block w-100 text-uppercase"
                            style="font-weight: bold"
                        >
                            Verify
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
<script>
import "../../css/app.css";
import { useToast } from "vue-toastification";
import "vue-toastification/dist/index.css";
const toast = useToast();
import axios_instance from "../utils/axios";
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
        async submitForm() {
            toast.info("Logging in to Room 911...", {
                timeout: 3000,
                position: "top-right",
            });
            this.errors = {}; // Reset errors
            if (!this.form.employee_id) {
                this.errors.employee_id = ["This field is required"];
                return;
            }

            try {
                const response = await axios_instance.post(
                    "/login-room",
                    this.form
                );
                if (response.status === 200) {
                    this.form.success = true;
                    toast.success("You'll be redirected", {
                        timeout: 3000,
                        position: "top-right",
                    });
                    await new Promise((resolve) =>
                        setTimeout(() => {
                            window.location.href = "https://www.lifefile.net/";
                            resolve();
                        }, 1000)
                    );
                }
            } catch (error) {
                if (error.response && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }
                if (error.response.status === 403) {
                    toast.error(error.response.data.message, {
                        timeout: 3000,
                        position: "top-right",
                    });
                }
            }
        },
    },
};
</script>
<style scoped src="/resources/css/app.css"></style>
