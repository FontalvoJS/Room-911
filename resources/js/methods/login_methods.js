import { useToast } from "vue-toastification";
import "vue-toastification/dist/index.css"; // Importar los estilos de Toastification
const toast = useToast();
import axios_instance from "../methods/axios";
export const validatePass = function (password) {
    if (password.length < 8) {
        toast.error("Password must be at least 8 characters", {
            timeout: 3000,
            position: "top-right",
        });
        return false;
    }
    return true;
}
export const submitForm = async function() {
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
}