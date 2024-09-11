<template>
    <div
        class="container d-flex justify-content-center align-items-center mt-5"
    >
        <div class="login-card">
            <div class="card-header">
                <h3 style="font-weight: bold">
                    You'r admin? Log in
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
                        <label for="email" class="form-label">Email</label>
                        <input
                            id="email"
                            v-model="form.email"
                            type="text"
                            class="form-control"
                            autofocus
                            required
                        />
                        <div v-if="errors.email" class="text-danger">
                            <span
                                v-for="(error, index) in errors.email"
                                :key="index"
                            >
                                {{ error }}</span
                            >
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="password" class="form-label"
                            >Password</label
                        >
                        <input
                            id="password"
                            v-model="form.password"
                            type="password"
                            class="form-control"
                            required
                        />
                        <div v-if="errors.password" class="text-danger">
                            <span
                                v-for="(error, index) in errors.password"
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
import { useToast } from "vue-toastification";
import "vue-toastification/dist/index.css"; // Importar los estilos de Toastification
const toast = useToast();
import axios_instance from "../utils/axios";
export default {
    data() {
        return {
            form: {
                email: "admin@pharmacy.com",
                password: "12345678",
                success: false,
            },
            errors: {},
        };
    },
    methods: {
        validatePass(password) {
            if (password.length < 8) {
                toast.error("Password must be at least 8 characters", {
                    timeout: 3000,
                    position: "top-right",
                });
                return false;
            }
            return true;
        },
        async submitForm() {
            this.errors = {}; // Reset errors

            if (!this.validatePass(this.form.password)) {
                this.errors.password = "Password must be at least 8 characters";
                return;
            }

            try {
                toast.info("Logging in...", {
                    timeout: 3000,
                    position: "top-right",
                });
                // Make a request to the login endpoint
                const response = await axios_instance.post("/login", this.form);
                if (response.status === 204) {
                    this.form.success = true;
                    toast.success("You'll be redirected", {
                        timeout: 3000,
                        position: "top-right",
                    });
                    await new Promise((resolve) =>
                        setTimeout(() => {
                            const baseUrl =
                                window.location.origin + "/dashboard";
                            window.location.href = baseUrl;
                            resolve();
                        }, 1000)
                    );
                }
            } catch (error) {
                // Handle validation errors from the backend
                if (error.response && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                }

            }
        },
    },
};
</script>
