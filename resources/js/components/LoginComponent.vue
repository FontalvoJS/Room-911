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
import { useThrottle } from "../methods/useThrottle";
import {submitForm, validatePass} from "../methods/login_methods";
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
        submitForm: useThrottle(submitForm, 2000),
        validatePass,
    },
};
</script>
