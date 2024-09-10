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
                        Employee Registration
                    </h5>
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                    ></button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-tabs" id="employeeTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button
                                class="nav-link active"
                                id="single-tab"
                                data-bs-toggle="tab"
                                data-bs-target="#single"
                                type="button"
                                role="tab"
                                aria-controls="single"
                                aria-selected="true"
                            >
                                Single Registration
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button
                                class="nav-link"
                                id="massive-tab"
                                data-bs-toggle="tab"
                                data-bs-target="#massive"
                                type="button"
                                role="tab"
                                aria-controls="massive"
                                aria-selected="false"
                            >
                                Massive Upload CSV | XLSX
                            </button>
                        </li>
                    </ul>
                    <div class="tab-content" id="employeeTabContent">
                        <div
                            class="tab-pane fade show active"
                            id="single"
                            role="tabpanel"
                            aria-labelledby="single-tab"
                        >
                            <form @submit.prevent="submitFormToAddEmployee">
                                <div class="form-group mt-3">
                                    <label for="name_employee"
                                        >First Name</label
                                    >
                                    <input
                                        type="text"
                                        name="name_employee"
                                        v-model="formEmployee.name"
                                        class="form-control"
                                        id="name_employee"
                                        placeholder="Enter first name"
                                        autofocus
                                    />
                                    <small
                                        v-if="formEmployee.errors.name"
                                        class="text-danger"
                                        >{{ formEmployee.errors.name }}</small
                                    >
                                </div>
                                <div class="form-group mt-3">
                                    <label for="lastname_employee"
                                        >Last Name</label
                                    >
                                    <input
                                        type="text"
                                        name="lastname_employee"
                                        v-model="formEmployee.lastname"
                                        class="form-control"
                                        id="lastname_employee"
                                        placeholder="Enter last name"
                                    />
                                    <small
                                        v-if="formEmployee.errors.lastname"
                                        class="text-danger"
                                        >{{
                                            formEmployee.errors.lastname
                                        }}</small
                                    >
                                </div>
                                <div class="form-group mt-3">
                                    <label for="employee_department"
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
                                        >
                                            {{ department.name }}
                                        </option>
                                    </select>
                                    <small
                                        v-if="formEmployee.errors.department"
                                        class="text-danger"
                                        >{{
                                            formEmployee.errors.department
                                        }}</small
                                    >
                                </div>
                                <div class="modal-footer mt-3">
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
                        <div
                            class="tab-pane fade"
                            id="massive"
                            role="tabpanel"
                            aria-labelledby="massive-tab"
                        >
                            <form @submit.prevent="submitFileUpload">
                                <div class="form-group mt-3">
                                    <label for="massive_upload" class="mb-3 mt-2 p-3 text-justify"
                                        >Employees will be imported immediately, please select the CSV or XLSX.</label
                                    >
                                    <input
                                        type="file"
                                        name="massive_upload"
                                        class="form-control"
                                        id="massive_upload"
                                        accept=".csv, .xlsx"
                                        @change="handleFile"
                                    />
                                    <small
                                        v-if="formEmployee.errors.file"
                                        class="text-danger"
                                        >{{ formEmployee.errors.file }}</small
                                    >
                                </div>
                                <div class="modal-footer mt-3">
                                    <button
                                        type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal"
                                    >
                                        Cancel
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
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
                                @click="
                                    updateEmployeeForm.enabled =
                                        !updateEmployeeForm.enabled
                                "
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
import { handleFile, submitFormToAddAdmin } from "../utils/dashboard_methods.js";

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
        handleFile: {
            type: Function,
            required: true,
        },
    },
};
</script>
