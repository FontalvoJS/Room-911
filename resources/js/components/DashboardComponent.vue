<template>
    <div>
        <!-- Modal for Admin Registration -->
        <div
            class="modal fade"
            id="registroAdmin"
            tabindex="-1"
            role="dialog"
            aria-labelledby="registroAdminLabel"
            aria-hidden="true"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="registroAdminLabel">
                            Admin registration
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form @submit.prevent="submitFormToAddAdmin">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name">Nombre</label>
                                <input
                                    type="text"
                                    name="name"
                                    v-model="form.name"
                                    class="form-control"
                                    id="name"
                                    placeholder="Ingrese su nombre"
                                    autofocus
                                />
                                <small v-if="errors.name" class="text-danger">{{ errors.name }}</small>
                            </div>
                            <div class="form-group">
                                <label for="email">Correo electrónico</label>
                                <input
                                    type="email"
                                    class="form-control"
                                    v-model="form.email"
                                    id="email"
                                    placeholder="Ingrese su correo electrónico"
                                />
                                <small v-if="errors.email" class="text-danger">{{ errors.email }}</small>
                            </div>
                            <div class="form-group">
                                <label for="password">Contraseña</label>
                                <input
                                    type="password"
                                    v-model="form.password"
                                    class="form-control"
                                    id="password"
                                    placeholder="Ingrese su contraseña"
                                />
                                <small v-if="errors.password" class="text-danger">{{ errors.password }}</small>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button
                                type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal"
                            >
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-dark" :disabled="isLoading">
                                <span v-if="isLoading" class="spinner-border spinner-border-sm"></span>
                                Registrar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Main Container -->
        <div class="container py-5 mt-4 custom_shadow">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3">Administrative Menu</h1>
                <div>
                    <span>
                        <strong><i class="fa fa-clock"></i></strong>
                        <small id="currentTime">{{ currentTime || "Initializing time" }}</small>
                    </span>

                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <div class="input-group mb-3">
                    <input
                        type="text"
                        class="form-control"
                        placeholder="Search by employee ID"
                        aria-label="Search by employee ID"
                        v-model="filters.employeeId"
                    />
                    <select class="form-select" aria-label="Filter by department" v-model="filters.department">
                        <option value="">Filter by department</option>
                        <option value="1">Department 1</option>
                        <option value="2">Department 2</option>
                    </select>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <label for="initial-access-date" class="form-label">Initial access date:</label>
                        <input
                            type="date"
                            class="form-control"
                            id="initial-access-date"
                            v-model="filters.initialAccessDate"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="final-access-date" class="form-label">Final access date:</label>
                        <input
                            type="date"
                            class="form-control"
                            id="final-access-date"
                            v-model="filters.finalAccessDate"
                        />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 d-flex align-items-end filter-btns mt-2">
                        <button class="btn btn-dark" @click.prevent="applyFilters">Filter</button>
                        <button class="btn btn-secondary" @click.prevent="clearFilters">Clear filter</button>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-end mb-3">
                <button
                    type="button"
                    class="btn btn-new-employee"
                    style="margin-right: 5px"
                >
                    New employee
                </button>
                <button
                    type="button"
                    class="btn btn-new-employee"
                    data-bs-toggle="modal"
                    data-bs-target="#registroAdmin"
                >
                    Add admin
                </button>
            </div>

            <!-- Employees Table -->
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th scope="col">Employee ID</th>
                        <th scope="col">Firstname ID</th>
                        <th scope="col">Lastname</th>
                        <th scope="col">Department</th>
                        <th scope="col">Total access</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="employee in employees" :key="employee.id">
                        <td>{{ employee.id }}</td>
                        <td>{{ employee.firstname }}</td>
                        <td>{{ employee.lastname }}</td>
                        <td>{{ employee.department }}</td>
                        <td>{{ employee.totalAccess }}</td>
                        <td class="action-buttons">
                            <button class="btn btn-sm btn-outline-primary btn-custom">
                                Update
                            </button>
                            <button
                                class="btn btn-sm btn-outline-secondary btn-custom"
                                :disabled="!employee.enabled"
                                @click="toggleEnable(employee)"
                            >
                                {{ employee.enabled ? 'Disable' : 'Enable' }}
                            </button>
                            <button class="btn btn-sm btn-outline-info btn-custom">
                                History
                            </button>
                            <button class="btn btn-sm btn-outline-danger btn-custom">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <tr v-if="employees.length === 0">
                        <td colspan="6" class="text-center">No employees found</td>
                    </tr>
                </tbody>
            </table>

            <!-- Pagination Section -->
            <div class="pagination-section">
                <span>Page {{ currentPage }} of {{ totalPages }}</span>
                <!-- Add pagination controls as needed -->
            </div>
        </div>
    </div>
</template>

<script>
import axios_instance from '../utils/axios';
import { useToast } from "vue-toastification";
import "vue-toastification/dist/index.css"; // Importar los estilos de Toastification
const toast = useToast();
export default {
    data() {
        return {
            currentTime: "",
            form: {
                name: "",
                email: "",
                password: "",
                isAdmin: 1,
            },
            errors: {},
            isLoading: false,
            filters: {
                employeeId: '',
                department: '',
                initialAccessDate: '2016-05-12',
                finalAccessDate: '2016-05-12',
            },
            employees: [
                // Ejemplo de datos, reemplaza con datos reales
                { id: '1000001', firstname: 'John', lastname: 'Doe', department: 'Department 1', totalAccess: 99, enabled: false },
                { id: '1000002', firstname: 'Jin', lastname: 'Doi', department: 'Department 2', totalAccess: 88, enabled: true },
            ],
            currentPage: 1,
            totalPages: 1,
        };
    },
    mounted() {
        this.showTime();
        setInterval(() => {
            this.showTime();
        }, 1000);
    },
    methods: {
        showTime() {
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
        },
        validateForm() {
            this.errors = {};

            if (!this.form.name) {
                this.errors.name = "El nombre es requerido.";
            }
            if (!this.form.email) {
                this.errors.email = "El correo electrónico es requerido.";
            } else if (!this.validateEmail(this.form.email)) {
                this.errors.email = "El correo electrónico no es válido.";
            }
            if (!this.form.password || this.form.password.length < 6) {
                this.errors.password = "La contraseña debe tener al menos 6 caracteres.";
            }

            return Object.keys(this.errors).length === 0;
        },
        validateEmail(email) {
            const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;
            return re.test(email);
        },
        async submitFormToAddAdmin() {
            if (!this.validateForm()) {
                return;
            }
            this.isLoading = true;
            try {
                const response = await axios_instance.post("/create-admin", this.form);
                if (response.status === 201) {
                    toast.success(response.data.message, {
                        timeout: 3000,
                        position: "top-center",
                    });
                    this.resetForm();
                    // Cerrar el modal
                    const modalElement = document.getElementById('registroAdmin');
                    const modal = bootstrap.Modal.getInstance(modalElement);
                    if (modal) {
                        modal.hide();
                    }
                }
            } catch (error) {
                if (error.response && error.response.data.errors) {
                    this.errors = error.response.data.errors;
                } else {
                    toast.error("Ocurrió un error al registrar el administrador.", {
                        timeout: 3000,
                        position: "top-center",
                    });
                }
            } finally {
                this.isLoading = false;
            }
        },
        resetForm() {
            this.form.name = '';
            this.form.email = '';
            this.form.password = '';
            this.errors = {};
        },
        applyFilters() {
            // Implementa la lógica de filtrado aquí
            // Por ejemplo, hacer una solicitud al backend con los filtros
        },
        clearFilters() {
            this.filters.employeeId = '';
            this.filters.department = '';
            this.filters.initialAccessDate = '2016-05-12';
            this.filters.finalAccessDate = '2016-05-12';
            // Implementa la lógica para limpiar los filtros aquí
        },
        toggleEnable(employee) {
            // Implementa la lógica para habilitar/deshabilitar un empleado
            // Por ejemplo, hacer una solicitud al backend para actualizar el estado
            employee.enabled = !employee.enabled;
        },
    },
};
</script>

<style scoped>
/* Encabezado */
.table th,
.table td {
    vertical-align: middle;
    text-align: center;
}
.btn-custom {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
    border-radius: 0.2rem;
}
.btn-history {
    background-color: #ffc107;
    color: white;
}
.btn-delete {
    background-color: #dc3545;
    color: white;
}
.input-group-text {
    font-weight: 500;
}
.filter-section {
    margin-bottom: 20px;
}
.filter-btns {
    display: flex;
    gap: 10px;
}
.action-buttons {
    display: flex;
    justify-content: space-around;
}
.btn-new-employee {
    background-color: #0d6efd;
    color: white;
}
.pagination-section {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
#currentTime {
    padding: 6px;
    border-radius: 5px;
    font-weight: 700;
    color: #ef7f1f;
}

.username {
    color: #ef7f1f;
    font-weight: 700;
}

.modal-content {
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.22);
    background-color: #fff;
}

.modal-header {
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 15px;
    margin-bottom: 15px;
}

.modal-title {
    font-weight: bold;
    font-size: 18px;
}

.modal-body {
    padding: 20px;
}

.form-group {
    margin-bottom: 1rem;
}

.form-control {
    border-radius: 8px;
    padding: 10px;
    font-size: 16px;
}

.btn-dark {
    background-color: #333;
    border-color: #333;
    color: #fff;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 8px;
}
.custom_shadow {
    padding: 2%;
    border-radius: 5px;
    box-shadow: 0 1px 20px 0px #00000040;
}
.btn-secondary {
    background-color: #e0e0e0;
    border-color: #e0e0e0;
    color: #333;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 8px;
}
.text-danger {
    font-size: 0.875em;
}
</style>
