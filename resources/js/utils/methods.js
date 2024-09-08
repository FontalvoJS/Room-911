import axios_instance from "./axios.js";
import { useToast } from "vue-toastification";
import "vue-toastification/dist/index.css"; // Importar los estilos de Toastification
const toast = useToast();
import "../../css/dashboard.css";

export const setDataUpdate = function (employee) {
    const departments = {
        Research: 1,
        Production: 2,
        Security: 3,
        Laboratory: 4,
    };
    this.updateEmployeeForm.id = employee.id;
    this.updateEmployeeForm.has_access = employee.has_access ? true : false;
    this.updateEmployeeForm.name = employee.name;
    this.updateEmployeeForm.last_name = employee.last_name;
    this.updateEmployeeForm.department = departments[employee.department];
};
export const validateFormAdmin = function () {
    this.formAdmin.errors = {};

    if (!this.formAdmin.name) {
        this.formAdmin.errors.name = "El nombre es requerido.";
    }
    if (!this.formAdmin.email) {
        this.formAdmin.errors.email = "El correo electrónico es requerido.";
    } else if (!this.validateEmail(this.formAdmin.email)) {
        this.formAdmin.errors.email = "El correo electrónico no es válido.";
    }
    if (!this.formAdmin.password || this.formAdmin.password.length < 6) {
        this.formAdmin.errors.password =
            "La contraseña debe tener al menos 6 caracteres.";
    }

    return Object.keys(this.formAdmin.errors).length === 0;
};

export const validateEmail = function (email) {
    const re =
        /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;
    return re.test(email);
};

export const submitFormToAddAdmin = async function () {
    if (!this.validateFormAdmin()) {
        return;
    }
    this.formAdmin.isLoading = true;
    try {
        const response = await axios_instance.post(
            "/create-admin",
            this.formAdmin
        );
        if (response.status === 201) {
            toast.success(response.data.message, {
                timeout: 3000,
                position: "top-center",
            });
            this.resetForm(true);
        }
    } catch (error) {
        if (error.response && error.response.data.errors) {
            this.formAdmin.errors = error.response.data.errors;
        } else {
            toast.error("Ocurrió un error al registrar el administrador.", {
                timeout: 3000,
                position: "top-center",
            });
        }
    } finally {
        this.formAdmin.isLoading = false;
    }
};

export const submitFormToAddEmployee = async function () {
    if (!this.validateFormEmployee()) {
        return;
    }
    this.formEmployee.isLoading = true;
    try {
        const response = await axios_instance.post(
            "/create-employee",
            this.formEmployee
        );
        if (response.status === 201) {
            toast.success(response.data.message, {
                timeout: 3000,
                position: "top-center",
            });
            await this.getEmployees();
            this.resetForm(false);
        }
    } catch (error) {
        if (error.response && error.response.data.errors) {
            this.formEmployee.errors = error.response.data.errors;
            toast.error(
                "Ocurrio un error al registrar el empleado: " +
                    error.response.data.message
            );
        }
    } finally {
        this.formEmployee.isLoading = false;
    }
};
export const validateFormEmployee = async function () {
    this.formEmployee.errors = {};

    if (!this.formEmployee.name) {
        this.formEmployee.errors.name = "El nombre es requerido.";
    }
    if (!this.formEmployee.lastname) {
        this.formEmployee.errors.lastname = "El apellido es requerido.";
    }
    if (!this.formEmployee.department) {
        this.formEmployee.errors.department = "El departamento es requerido.";
    }

    return Object.keys(this.formEmployee.errors).length === 0;
};
export const resetForm = function (isAdmin) {
    if (isAdmin) {
        this.formAdmin.name = "";
        this.formAdmin.email = "";
        this.formAdmin.password = "";
        this.formAdmin.errors = {};
    } else {
        this.formEmployee.name = "";
        this.formEmployee.lastname = "";
        this.formEmployee.department = "";
        this.formEmployee.errors = {};
    }
};
export const resetFormUpdate = function () {
    this.updateEmployeeForm.id = "";
    this.updateEmployeeForm.name = "";
    this.updateEmployeeForm.last_name = "";
    this.updateEmployeeForm.department = "";
    this.updateEmployeeForm.errors = {};
};
export const applyFilters = function () {
    // Implementa la lógica para aplicar los filtros
};
export const clearFilters = function () {
    this.filters.employeeId = "";
    this.filters.department = "";
    this.filters.initialAccessDate = "2016-05-12";
    this.filters.finalAccessDate = "2016-05-12";
    // Implementa la lógica para limpiar los filtros aquí
};
export const toggleEnable = function (employee) {
    // Implementa la lógica para habilitar/deshabilitar un empleado
    // Por ejemplo, hacer una solicitud al backend para actualizar el estado
    employee.has_access = !employee.has_access;
};
export const copyToClipboard = function (text, hasAccess) {
    if (hasAccess) {
        navigator.clipboard.writeText(text);
        toast.info("Copied to clipboard: " + text, {
            timeout: 3000,
            position: "top-center",
        });
    } else {
        navigator.clipboard.writeText(text);
        toast.info(
            "Copy to clipboard but this employee is not allowed to access the room.",
            {
                timeout: 3000,
                position: "top-center",
            }
        );
    }
};
export const deleteEmployee = async function (id) {
    try {
        const response = await axios_instance.post(`/delete-employee/${id}`);
        if (response.status === 200) {
            toast.success(response.data.message, {
                timeout: 3000,
                position: "top-center",
            });
            this.getEmployees();
        }
    } catch (error) {
        console.error(error);
    }
};
export const updateEmployee = async function () {
    try {
        const id = this.updateEmployeeForm.id;
        const data = {
            name: this.updateEmployeeForm.name,
            last_name: this.updateEmployeeForm.last_name,
            department: this.updateEmployeeForm.department,
            has_access: this.updateEmployeeForm.has_access,
        };
        const response = await axios_instance.post(
            `/update-employee/${id}`,
            data
        );
        if (response.status === 200) {
            toast.success(response.data.message, {
                timeout: 3000,
                position: "top-center",
            });
            await this.getEmployees();
            this.resetFormUpdate();
        }
    } catch (error) {
        console.error(error);
    }
};
export const getEmployees = async function () {
    try {
        const response = await axios_instance.get("/get-employees");
        if (response.status === 200) {
            this.employees = response.data.employees;
        }
    } catch (error) {
        console.error(error);
    }
};
export const getDepartments = async function () {
    try {
        const response = await axios_instance.get("/get-departments");
        if (response.status === 200) {
            this.departments = response.data.departments;
        }
    } catch (error) {
        console.error(error);
    }
};

export const showTime = function () {
    const now = new Date();
    let hours = now.getHours();
    let minutes = now.getMinutes();
    let seconds = now.getSeconds();

    let ampm = hours >= 12 ? "PM" : "AM";
    hours = hours % 12;
    hours = hours ? hours : 12;

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    const currentTime = hours + ":" + minutes + ":" + seconds + " " + ampm;
    this.currentTime = currentTime;
};
