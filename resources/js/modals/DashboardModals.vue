<template>
    <!-- Modal for Admin Registration -->
    <div
        class="modal fade"
        id="adminRegister"
        tabindex="-1"
        role="dialog"
        aria-labelledby="adminRegisterLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="adminRegisterLabel">
                        Admin registration
                    </h5>
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                    ></button>
                </div>
                <form @submit.prevent="submitFormToAddAdmin">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name">Nombre</label>
                            <input
                                type="text"
                                name="name"
                                v-model="formAdmin.name"
                                class="form-control"
                                id="name"
                                placeholder="Ingrese su nombre"
                                autofocus
                            />
                            <small
                                v-if="formAdmin.errors.name"
                                class="text-danger"
                                >{{ formAdmin.errors.name }}</small
                            >
                        </div>
                        <div class="form-group">
                            <label for="email">Correo electrónico</label>
                            <input
                                type="email"
                                class="form-control"
                                v-model="formAdmin.email"
                                id="email"
                                placeholder="Ingrese su correo electrónico"
                            />
                            <small
                                v-if="formAdmin.errors.email"
                                class="text-danger"
                                >{{ formAdmin.errors.email }}</small
                            >
                        </div>
                        <div class="form-group">
                            <label for="password">Contraseña</label>
                            <input
                                type="password"
                                v-model="formAdmin.password"
                                class="form-control"
                                id="password"
                                autocomplete=""
                                placeholder="Ingrese su contraseña"
                            />
                            <small
                                v-if="formAdmin.errors.password"
                                class="text-danger"
                                >{{ formAdmin.errors.password }}</small
                            >
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal"
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            class="btn btn-dark"
                            :disabled="formAdmin.isLoading"
                        >
                            <span
                                v-if="formAdmin.isLoading"
                                class="spinner-border spinner-border-sm"
                            ></span>
                            Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal for Employee Registration -->
    <div
        class="modal fade"
        id="employeeRegister"
        tabindex="-1"
        role="dialog"
        aria-labelledby="employeeRegisterLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="employeeRegisterLabel">
                        Employee registration
                    </h5>
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                    ></button>
                </div>
                <form @submit.prevent="submitFormToAddEmployee">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name_employee">First name</label>
                            <input
                                type="text"
                                name="name_employee"
                                v-model="formEmployee.name"
                                class="form-control"
                                id="name_employee"
                                placeholder="Ingrese su nombre"
                                autofocus
                            />
                            <small
                                v-if="formEmployee.errors.name"
                                class="text-danger"
                                >{{ formEmployee.errors.name }}</small
                            >
                        </div>
                        <div class="form-group">
                            <label for="name_employee">Last name</label>
                            <input
                                type="text"
                                name="lastname_employee"
                                v-model="formEmployee.lastname"
                                class="form-control"
                                id="lastname_employee"
                                placeholder="Lastname"
                                autofocus
                            />
                            <small
                                v-if="formEmployee.errors.lastname"
                                class="text-danger"
                                >{{ formEmployee.errors.lastname }}</small
                            >
                        </div>
                        <div class="form-group">
                            <label for="employee_department" _edit
                                >Department</label
                            >
                            <select
                                class="form-select"
                                v-model="formEmployee.department"
                            >
                                <option value="" selected>
                                    Select a department
                                </option>
                                <option
                                    v-for="department in departments"
                                    :key="department.id"
                                    :value="department.id"
                                    :selected="department.id == 1"
                                >
                                    {{ department.name }}
                                </option>
                            </select>
                            <small
                                v-if="formEmployee.errors.department"
                                class="text-danger"
                                >{{ formEmployee.errors.department }}</small
                            >
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal"
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            @click.prevent="submitFormToAddEmployee"
                            class="btn btn-dark"
                            :disabled="formEmployee.isLoading"
                        >
                            <span
                                v-if="formEmployee.isLoading"
                                class="spinner-border spinner-border-sm"
                            ></span>
                            Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal for Employee Update -->
    <div
        class="modal fade"
        id="employeeEdit"
        tabindex="-1"
        role="dialog"
        aria-labelledby="employeeEditLabel"
        aria-hidden="true"
    >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="employeeEditLabel">
                        Update employee
                    </h5>
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                    ></button>
                </div>
                <form @submit.prevent="updateEmployee">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="name_employee_edit">First name</label>
                            <input
                                type="text"
                                name="name_employee_edit"
                                v-model="updateEmployeeForm.name"
                                class="form-control"
                                id="name_employee_edit"
                                placeholder="Ingrese su nombre"
                                autofocus
                            />
                            <small
                                v-if="updateEmployeeForm.errors.name"
                                class="text-danger"
                                >{{ updateEmployeeForm.errors.name }}</small
                            >
                        </div>
                        <div class="form-group">
                            <label for="name_employee_edit">Last name</label>
                            <input
                                type="text"
                                name="lastname_employee_edit"
                                v-model="updateEmployeeForm.last_name"
                                class="form-control"
                                id="lastname_employee_edit"
                                placeholder="Lastname"
                                autofocus
                            />
                            <small
                                v-if="updateEmployeeForm.errors.last_name"
                                class="text-danger"
                                >{{
                                    updateEmployeeForm.errors.last_name
                                }}</small
                            >
                        </div>
                        <div class="form-group">
                            <label for="employee_department_edit"
                                >Department</label
                            >
                            <select
                                class="form-select"
                                v-model="updateEmployeeForm.department"
                            >
                                <option value="" selected>
                                    Select a department
                                </option>
                                <option
                                    v-for="department in departments"
                                    :key="department.id"
                                    :value="department.id"
                                >
                                    {{ department.name }}
                                </option>
                            </select>
                            <small
                                v-if="updateEmployeeForm.errors.department"
                                class="text-danger"
                                >{{
                                    updateEmployeeForm.errors.department
                                }}</small
                            >
                        </div>
                        <div class="form-check form-switch">
                            <input
                                class="form-check-input"
                                type="checkbox"
                                v-model="updateEmployeeForm.has_access"
                                @click="updateEmployeeForm.enabled = !updateEmployeeForm.enabled"
                                id="flexSwitchCheckDefault"
                            />
                            <label
                                class="form-check-label"
                                for="flexSwitchCheckDefault"
                            >
                                Enabled
                            </label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal"
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            class="btn btn-dark"
                            :disabled="updateEmployeeForm.isLoading"
                        >
                            <span
                                v-if="updateEmployeeForm.isLoading"
                                class="spinner-border spinner-border-sm"
                            ></span>
                            Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>
<script>
import { submitFormToAddAdmin } from "../utils/methods";

export default {
    name: "DashboardModals",
    props: {
        formAdmin: {
            type: Object,
            required: true,
        },
        departments: {
            type: Array,
            required: true,
        },
        formEmployee: {
            type: Object,
            required: true,
        },
        updateEmployeeForm: {
            type: Object,
            required: true,
        },
        submitFormToAddAdmin: {
            type: Function,
            required: true,
        },
        submitFormToAddEmployee: {
            type: Function,
            required: true,
        },
        updateEmployee: {
            type: Function,
            required: true,
        },
    },
};
</script>
