<template>
    <div
        class="container d-flex justify-content-center align-items-center mt-5"
    >
        <div class="login-card">
            <div class="card-header">
                <h3 style="font-weight: bold">
                    You'r admin? Log in
                    <span class="text-dark" style="float: right"
                        ><i class="fas fa-lock"></i
                    ></span>
                </h3>
            </div>

            <div class="card-body">
                <form @submit.prevent="submitForm">
                    <div class="form-group mb-3">
                        <label for="email" class="form-label">Username</label>
                        <input
                            id="email"
                            v-model="form.email"
                            type="email"
                            class="form-control"
                            required
                            autofocus
                        />
                        <span v-if="errors.email" class="text-danger">{{
                            errors.email
                        }}</span>
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
                        <span v-if="errors.password" class="text-danger">{{
                            errors.password
                        }}</span>
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
                email: "",
                password: "",
            },
            errors: {},
        };
    },
    methods: {
        validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const isValid = re.test(email);

            if (!isValid) {
                toast.error("Please enter a valid email address", {
                    timeout: 3000,
                    onClose: () => {
                        this.form.email = "";
                    },
                    onClick: () => {
                        this.form.email = "";
                    },
                    position: "top-center",
                });
            }

            return isValid;
        },
        validatePass(password) {
            if (password.length < 8) {
                toast.error("Password must be at least 8 characters", {
                    timeout: 3000,
                    onClose: () => {
                        this.form.password = "";
                    },
                    onClick: () => {
                        this.form.password = "";
                    },
                    position: "top-center",
                });
                return false;
            }
            return true;
        },
        async submitForm() {
            this.errors = {}; // Reset errors

            if (!this.validateEmail(this.form.email)) {
                this.errors.email = "Please enter a valid email address";
                return;
            }
            if (!this.validatePass(this.form.password)) {
                this.errors.password = "Password must be at least 8 characters";
                return;
            }

            try {
                // Make a request to the login endpoint
                const response = await axios_instance.post("/login", this.form);
            } catch (error) {
                // Handle validation errors from the backend
                if (error.response && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                    console.log(error.response.data.errors);
                }
            }
        },
    },
};
</script>

<style scoped>
/* General container styles */
.container {
    padding: 0;
}

/* Center the card in the viewport */
.login-card {
    width: 100%;
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.22);
    background-color: #fff;
}

.card-header {
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 15px;
    margin-bottom: 15px;
}

.card-header h2 {
    margin: 0;
}

.form-group {
    margin-bottom: 1rem;
}

.form-check-input {
    margin-right: 0.5rem;
}
</style>
